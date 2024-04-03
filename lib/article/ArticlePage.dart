import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibra_jt/article/ArticleData.dart';
import 'package:provider/provider.dart';
import 'package:ibra_jt/article/Article.dart';
import 'EditArticle.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  void CreateArticle(BuildContext context) {
    int id = Provider.of<ArticleData>(context, listen: false)
            .getAllArticles()
            .length +
        1;
    Article newArticle = Article(
      id: id,
      text: '',
      hashtags: '',
    );

    goToArticlePage(context, newArticle, true);
  }

  void goToArticlePage(
      BuildContext context, Article article, bool isNewArticle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditArticlePage(
          article: article,
          isNewArticle: isNewArticle,
        ),
      ),
    );
  }

  void deleteArticle(Article article) {
    Provider.of<ArticleData>(context, listen: false).allArticle.remove(article);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleData>(
      builder: (context, value, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => CreateArticle(context),
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                  right: 10.0, left: 10.0, bottom: 10.0, top: 5.0),
              child: Text(
                'Cerita Yang Telah Kamu Bagikan!',
                style: TextStyle(
                  fontFamily: 'Inter-Bold',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.getAllArticles().length,
                itemBuilder: (context, index) {
                  final article = value.getAllArticles()[index];
                  return ListTile(
                    title: Text(article.text),
                    onTap: () => goToArticlePage(context, article, false),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
