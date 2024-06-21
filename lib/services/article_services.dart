import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/article_model.dart';
import 'user_services.dart' as user_services;

final _storageInstance = FirebaseStorage.instance.ref().child('articles');
final _firestoreInstance =
    FirebaseFirestore.instance.collection('articles').withConverter(
          fromFirestore: ArticleModel.fromFirestore,
          toFirestore: (article, _) => article.toMap(),
        );
final _publishedInstance = _firestoreInstance.where('datePublished',
    isLessThanOrEqualTo: DateTime.now());

Future<void> createArticle({
  required String title,
  required Uint8List coverImage,
  required DateTime datePublished,
  required String city,
  required String content,
  required List<String> tags,
}) async {
  final articleRef = _firestoreInstance.doc();
  final newArticle = ArticleModel(
    id: articleRef.id,
    authorId: user_services.currentUser!.id,
    title: title,
    datePublished: datePublished,
    city: city,
    content: content,
    tags: tags,
    coverImageUrl: '',
    dateCreated: DateTime.now(),
    isFeatured: false,
  );
  await articleRef.set(newArticle);
  await _setCoverImage(articleRef.id, coverImage);
}

Future<void> _setCoverImage(String id, Uint8List coverImage) async {
  final coverImageRef = _storageInstance.child(id).child('cover_image.jpg');
  await coverImageRef.putData(coverImage);
  final articleRef = _firestoreInstance.doc(id);
  await articleRef.update(
    {
      'coverImageUrl': await coverImageRef.getDownloadURL(),
    },
  );
}

Future<DocumentSnapshot<ArticleModel>> getArticle(String id) {
  return _firestoreInstance.doc(id).get();
}

Stream<QuerySnapshot<ArticleModel>> getArticlesStream() {
  return _publishedInstance.snapshots();
}

Future<QuerySnapshot<ArticleModel>> getFeaturedArticle() {
  return _publishedInstance.where('isFeatured', isEqualTo: true).get();
}

Future<QuerySnapshot<ArticleModel>> getSortedArticlesWithLimit({
  required String field,
  bool isDescending = false,
  required int limit,
}) {
  return _publishedInstance
      .orderBy(field, descending: isDescending)
      .limit(limit)
      .get();
}

Stream<QuerySnapshot<ArticleModel>> getDraftsArticleStreamFromAuthorId(
    String authorId) {
  return _firestoreInstance
      .where('authorId', isEqualTo: authorId)
      .where('datePublished', isGreaterThan: DateTime.now())
      .snapshots();
}

Stream<QuerySnapshot<ArticleModel>> getPublishedArticlesStreamFromAuthorId(
  String authorId,
) {
  return _publishedInstance.where('authorId', isEqualTo: authorId).snapshots();
}

Stream<QuerySnapshot<ArticleModel>> getSortedArticlesStream(
  String field, {
  bool isDescending = false,
}) {
  return _publishedInstance
      .orderBy(field, descending: isDescending)
      .snapshots();
}

Future<void> updateArticle(
  String id, {
  required String title,
  required Uint8List coverImage,
  required DateTime datePublished,
  required String city,
  required String content,
  required List<String> tags,
}) async {
  final articleRef = _firestoreInstance.doc(id);
  final articleData = {
    'title': title,
    'datePublished': datePublished,
    'city': city,
    'content': content,
    'tags': tags,
  };
  await articleRef.update(articleData);
  await _setCoverImage(id, coverImage);
}

Future<void> updateFeaturedStatus(String id, {required bool isFeatured}) async {
  final articleRef = _firestoreInstance.doc(id);
  await articleRef.update({'isFeatured': isFeatured});
}

Future<void> deleteArticle(String id) async {
  await _firestoreInstance.doc(id).delete();
}
