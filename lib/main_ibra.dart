import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ibra_jt/article/ArticleData.dart';
import 'package:ibra_jt/article/ArticlePage.dart';
import 'package:ibra_jt/article/Article_Tab.dart';
import 'package:ibra_jt/article/EditArticle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArticleData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ArticleTab(), // Set ArticleTab as the homepage
      ),
    );
  }
}
