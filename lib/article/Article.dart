import 'dart:io';

class Article {
  int id;
  String text;
  String hashtags;
  File? header;

  Article({
    required this.id,
    required this.text,
    required this.hashtags,
    this.header,
  });
}
