import 'Article.dart';
import 'package:flutter/material.dart';

class ArticleData extends ChangeNotifier {
  List<Article> allArticle = [
    Article(id: 0, text: 'Try', hashtags: '#Belajar'),
  ];

  List<Article> getAllArticles() {
    return allArticle;
  }

  void addNewArticle(Article article) {
    allArticle.add(article);
    notifyListeners();
  }

  void updateArticle(Article article, String text) {
    for (int i = 0; i < allArticle.length; i++) {
      if (allArticle[i].id == article.id) {
        allArticle[i].text = text;
      }
    }
  }

  void deleteArticle(Article article) {
    allArticle.remove(article);
  }
}
