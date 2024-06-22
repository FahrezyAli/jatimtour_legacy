import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart' as intl;
import 'package:rowbuilder/rowbuilder.dart';

import '../../../constants.dart';
import '../../../models/article_model.dart';
import '../../../services/article_services.dart';
import 'mobile_scaffold.dart';

class ArticlePageMobile extends StatelessWidget {
  final String articleId;
  final _quillController = QuillController.basic();

  ArticlePageMobile({required this.articleId, super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      body: FutureBuilder(
        future: getArticle(articleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildPage(context, snapshot.data!.data()!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, ArticleModel article) {
    _quillController.document = Document.fromJson(jsonDecode(article.content));
    _quillController.readOnly = true;
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Image.network(article.coverImageUrl)),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    article.title,
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
                    FutureBuilder(
                      future: article.getAuthorUsernameFromAuthorId(),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data ?? '',
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16.0,
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          intl.DateFormat('d MMMM y')
                              .format(article.datePublished),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 15.0, bottom: 10.0, right: 15.0),
                child: RowBuilder(
                  itemCount: article.tags.length,
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
                        '#${article.tags[index]}',
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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
              ),
            ],
          ),
        )
      ],
    );
  }
}
