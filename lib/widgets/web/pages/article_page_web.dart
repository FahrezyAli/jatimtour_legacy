import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/article_model.dart';
import 'package:jatimtour/widgets/web/pages/web_scaffold.dart';
import 'package:rowbuilder/rowbuilder.dart';

class ArticlePageWeb extends StatelessWidget {
  final String articleId;
  final QuillController _quillController = QuillController.basic();

  ArticlePageWeb({required this.articleId, super.key});

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      body: FutureBuilder(
        future: Modular.get<ArticleModel>().getArticleFromId(articleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildArticlePage(context, snapshot.data!.data()!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildArticlePage(
    BuildContext context,
    Map<String, dynamic> articleData,
  ) {
    _quillController.document =
        Document.fromJson(jsonDecode(articleData['content']));
    _quillController.readOnly = true;
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Image.asset(
                'assets/images/leading.png',
                repeat: ImageRepeat.repeatX,
              ),
              SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Image.network(articleData['coverImageUrl'])),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    articleData['title'],
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 15.0, right: 10.0),
                child: Row(
                  children: [
                    Text(
                      articleData['authorUsername'],
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16.0,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          DateFormat('d MMMM y')
                              .format(articleData['datePublished'].toDate()),
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    scrollable: false,
                    showCursor: false,
                    controller: _quillController,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('id'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 15.0, bottom: 10.0, right: 15.0),
                child: RowBuilder(
                  itemCount: articleData['tags'].length,
                  reversed: false,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 5.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: kPinkColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        '#${articleData['tags'][index]}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: kPinkColor,
                height: 80.0,
                width: MediaQuery.sizeOf(context).width,
                child: const Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 20.0),
                  child: Text(
                    "© 2024 JATIMTOUR",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
