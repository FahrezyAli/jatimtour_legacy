import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/article_model.dart';
import '../../../services/article_services.dart';
import '../cards/list_article_card_web.dart';
import 'web_scaffold.dart';

class SearchPageWeb extends StatefulWidget {
  const SearchPageWeb({super.key});

  @override
  State<SearchPageWeb> createState() => _SearchPageWebState();
}

class _SearchPageWebState extends State<SearchPageWeb> {
  List<ArticleModel>? queriedData;
  late List<ArticleModel> data;

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      body: Material(
        color: kBackgroundColor,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 50.0),
              child: Divider(thickness: 1.0, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: UnconstrainedBox(
                child: Container(
                  height: 40.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for article titles",
                        hintStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.0,
                        ),
                        suffixIcon: Icon(Icons.search),
                      ),
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.search,
                      onChanged: _searchArticle,
                      onFieldSubmitted: _searchArticle,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: getArticlesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    data = snapshot.data!.docs.map((e) => e.data()).toList();
                    queriedData ??= data;
                    return _buildPage();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchArticle(String query) {
    final List<ArticleModel> result = [];
    if (query.isEmpty) {
      setState(() {
        queriedData = data;
      });
    } else {
      for (final article in data) {
        if (article.title.toLowerCase().contains(query.toLowerCase())) {
          result.add(article);
        }
      }
      setState(() {
        queriedData = result;
      });
    }
  }

  Widget _buildPage() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: ListView.builder(
        itemCount: queriedData!.length,
        itemBuilder: (context, index) {
          return ListArticleCardWeb(
            articleId: queriedData![index].id,
            article: queriedData![index],
          );
        },
      ),
    );
  }
}
