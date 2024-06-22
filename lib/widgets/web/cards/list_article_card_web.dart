import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart' as intl;
import 'package:rowbuilder/rowbuilder.dart';

import '../../../constants.dart';
import '../../../models/article_model.dart';
import '../../../services/article_services.dart';

class ListArticleCardWeb extends StatelessWidget {
  final String articleId;
  final ArticleModel article;
  final bool withUpdateAndDelete;

  const ListArticleCardWeb({
    required this.articleId,
    required this.article,
    this.withUpdateAndDelete = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFE1E1E1),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 20.0,
          right: 20.0,
        ),
        child: InkWell(
          onTap: () {
            Modular.to.pushNamed('$articleRoute?articleId=$articleId');
          },
          child: Ink(
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Ink(
                  height: 100.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: NetworkImage(article.coverImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Ink(
                    height: 100,
                    padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future: article.getAuthorUsernameFromAuthorId(),
                          builder: (context, snapshot) {
                            return RichText(
                              text: TextSpan(
                                text: article.title,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '\n${snapshot.data ?? ''}, ${intl.DateFormat('d MMMM y').format(article.datePublished)}',
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: RowBuilder(
                            itemCount: article.tags.length > 3
                                ? 3
                                : article.tags.length,
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
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (withUpdateAndDelete)
                  Column(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Modular.to.pushNamed(
                              '$updateArticleRoute?articleId=$articleId',
                            );
                          }),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Hapus Artikel'),
                                content: const Text(
                                  'Apakah Anda yakin ingin menghapus artikel ini?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Modular.to.pop(context);
                                    },
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Modular.to.pop(context);
                                      deleteArticle(articleId);
                                    },
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
