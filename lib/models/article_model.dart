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
    final authorUsername = authorRef.data()!['username'];
    await articleRef.set(
      {
        'authorUsername': authorUsername,
        'title': title,
        'datePublished': datePublished,
        'city': city,
        'content': content,
        'tags': tags,
        'dateCreated': DateTime.now(),
      },
    );
    await setCoverImage(coverImage.readAsBytes(), articleRef.id);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionWithOrderByAndLimit({
    required String order,
    required bool isDescending,
    required int limit,
  }) async {
    return await FirebaseFirestore.instance
        .collection('articles')
        .orderBy(order, descending: isDescending)
        .limit(limit)
        .get();
  }
}
