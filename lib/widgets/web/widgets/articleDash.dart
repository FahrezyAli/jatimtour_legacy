import 'package:flutter/material.dart';
import 'package:jatimtour/models/article.dart';
import 'article_content.dart';
import 'package:intl/intl.dart';

class ArticleTable extends StatefulWidget {
  final List<Article> articles;

  const ArticleTable({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  _ArticleTableState createState() => _ArticleTableState();
}

class _ArticleTableState extends State<ArticleTable> {
  void _addArticle(Article newArticle) {
    setState(() {
      widget.articles.add(newArticle);
    });
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Navigate to register.dart
                  Article? newArticle = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArticleReg(
                              article: null,
                              textController: TextEditingController(),
                            )),
                  );

                  if (newArticle != null) {
                    _addArticle(newArticle);
                  }
                },
                child: Text('Add Article'), // Button label
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 15,
                  dataRowMaxHeight: 50,
                  columns: [
                    DataColumn(
                        label: Text(
                      'ID Article',
                      style: TextStyle(color: Colors.black),
                    )),
                    DataColumn(
                        label: Text(
                      'Title',
                      style: TextStyle(color: Colors.black),
                    )),
                    DataColumn(
                        label: Text('Content',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('City',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('Date',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('Hashtags',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('HeaderUrl',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('Actions',
                            style: TextStyle(color: Colors.black))),
                  ],
                  rows: widget.articles.asMap().entries.map<DataRow>((entry) {
                    final index = entry.key;
                    final article = entry.value;
                    return DataRow(cells: [
                      DataCell(Text('ABC' + (index + 1).toString(),
                          style: TextStyle(color: Colors.black))),
                      DataCell(SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                              width: 150,
                              child: Text(article.title,
                                  style: TextStyle(color: Colors.black))))),
                      DataCell(SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                              width: 300,
                              child: Text(article.content,
                                  style: TextStyle(color: Colors.black))))),
                      DataCell(Text(article.city,
                          style: TextStyle(color: Colors.black))),
                      DataCell(
                        Text(
                          DateFormat('yyyy-MM-dd').format(article.date),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      DataCell(SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                            width: 180,
                            child: Text('#' + article.hashtags,
                                style: TextStyle(color: Colors.black))),
                      )),
                      DataCell(Text(article.headerUrl,
                          style: TextStyle(color: Colors.black))),
                      DataCell(
                        Row(
                          children: [
                            InkWell(
                                onTap: () async {
                                  // Navigate to Register screen and wait for result
                                  Article? updatedArticle =
                                      await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArticleReg(
                                          article: article,
                                          textController:
                                              TextEditingController()),
                                    ),
                                  );
                                  // Update the profile if the result is not null
                                  if (updatedArticle != null) {
                                    setState(() {
                                      widget.articles[index] = updatedArticle;
                                    });
                                  }
                                },
                                child: Icon(Icons.edit, color: Colors.black)),
                            InkWell(
                                onTap: (() {
                                  setState(() {
                                    widget.articles.removeAt(index);
                                  });
                                  //
                                }),
                                child: Icon(Icons.delete, color: Colors.black)),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
