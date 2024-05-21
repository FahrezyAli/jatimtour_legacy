import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/article_model.dart';
import 'package:rowbuilder/rowbuilder.dart';

class ArticleCardMobile extends StatelessWidget {
  final String articleId;
  final Map<String, dynamic> articleData;
  final bool withUpdateAndDelete;

  const ArticleCardMobile({
    required this.articleId,
    required this.articleData,
    this.withUpdateAndDelete = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBackgroundColor,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/article?articleId=$articleId',
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 20.0,
            right: 20.0,
          ),
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
                  width: 160.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: NetworkImage(articleData['coverImageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Ink(
                    padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              text: articleData['title'],
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '\n${articleData['authorUsername']}, ${DateFormat('d MMMM y').format(articleData['datePublished'].toDate())}',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: RowBuilder(
                            itemCount: articleData['tags'].length > 3
                                ? 3
                                : articleData['tags'].length,
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
                                      context
                                          .read<ArticleModel>()
                                          .deleteArticlesWithId(articleId);
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
