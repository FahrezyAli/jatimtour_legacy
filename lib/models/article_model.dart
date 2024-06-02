import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

class ArticleModel {
  Future<void> setCoverImage(Future<Uint8List> dataStream, String id) async {
    final coverImageRef = FirebaseStorage.instance
        .ref()
        .child('articles')
        .child(id)
        .child('cover_image.jpg');
    final data = await dataStream;
    await coverImageRef.putData(data);
    final articleRef =
        FirebaseFirestore.instance.collection('articles').doc(id);
    await articleRef.update(
      {
        'coverImageUrl': await coverImageRef.getDownloadURL(),
      },
    );
  }

  Future<void> setData({
    required String title,
    required CroppedFile coverImage,
    required DateTime datePublished,
    required String city,
    required String content,
    required List<String> tags,
  }) async {
    final articleRef = FirebaseFirestore.instance.collection('articles').doc();
    final authorRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final authorUsername = authorRef['username'];
    await articleRef.set(
      {
        'authorUsername': authorUsername,
        'title': title,
        'datePublished': datePublished,
        'city': city,
        'content': content,
        'tags': tags,
        'dateCreated': DateTime.now(),
        'isFeatured': false,
      },
    );
    await setCoverImage(coverImage.readAsBytes(), articleRef.id);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getArticleFromId(String id) {
    return FirebaseFirestore.instance.collection('articles').doc(id).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFeaturedArticle() {
    return FirebaseFirestore.instance
        .collection('articles')
        .where('isFeatured', isEqualTo: true)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSortedArticlesWithLimit({
    required String field,
    bool isDescending = false,
    required int limit,
  }) async {
    return await FirebaseFirestore.instance
        .collection('articles')
        .orderBy(field, descending: isDescending)
        .limit(limit)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getArticleStreamFromAuthorUsername(
    String authorUsername,
  ) {
    return FirebaseFirestore.instance
        .collection('articles')
        .where('authorUsername', isEqualTo: authorUsername)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getArticlesStream() {
    return FirebaseFirestore.instance.collection('articles').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSortedArticlesStream(
      String field,
      {bool isDescending = false}) {
    return FirebaseFirestore.instance
        .collection('articles')
        .orderBy(field, descending: isDescending)
        .snapshots();
  }

  Future<void> updateArticleFromId(String id, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('articles')
        .doc(id)
        .update(data);
  }

  Future<void> deleteArticlesFromId(String id) async {
    await FirebaseFirestore.instance.collection('articles').doc(id).delete();
  }
}
