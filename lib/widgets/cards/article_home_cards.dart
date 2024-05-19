import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jatimtour/constants.dart';
import 'package:rowbuilder/rowbuilder.dart';

class ArticleHomeCards extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final DateTime datePublished;
  final List<dynamic> tags;

  const ArticleHomeCards({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.datePublished,
    required this.tags,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              imageUrl,
              width: 160.0,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 12.0, left: 5.0),
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: title,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text:
                                '\n$author, ${DateFormat('d MMMM y').format(datePublished)}',
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
                      itemCount: tags.length > 3 ? 3 : tags.length,
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
                            '#${tags[index]}',
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
        ],
      ),
    );
  }
}
