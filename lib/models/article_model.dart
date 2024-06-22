import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/user_services.dart';

class ArticleModel {
  final String id;
  final String authorId;
  final String title;
  final DateTime datePublished;
  final String city;
  final String content;
  final List<String> tags;
  final String coverImageUrl;
  final DateTime dateCreated;
  final bool isFeatured;

  ArticleModel({
    required this.id,
    required this.authorId,
    required this.title,
    required this.datePublished,
    required this.city,
    required this.content,
    required this.tags,
    required this.coverImageUrl,
    required this.dateCreated,
    required this.isFeatured,
  });

  factory ArticleModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> data,
    SnapshotOptions? options,
  ) {
    return ArticleModel(
      id: data.id,
      authorId: data['authorId'],
      title: data['title'],
      datePublished: data['datePublished'].toDate(),
      city: data['city'],
      content: data['content'],
      tags: List<String>.from(data['tags']),
      coverImageUrl: data['coverImageUrl'],
      dateCreated: data['dateCreated'].toDate(),
      isFeatured: data['isFeatured'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authorId': authorId,
      'title': title,
      'datePublished': datePublished,
      'city': city,
      'content': content,
      'tags': tags,
      'coverImageUrl': coverImageUrl,
      'dateCreated': dateCreated,
      'isFeatured': isFeatured,
    };
  }

  Future<String> getAuthorUsernameFromAuthorId() {
    return getUser(authorId).then(
      (user) {
        if (user.exists) {
          return user.data()!.username;
        } else {
          return 'Deleted Account';
        }
      },
    );
  }
}
