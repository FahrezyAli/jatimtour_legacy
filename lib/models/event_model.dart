import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

class EventModel {
  Future<void> setCoverImage(Future<Uint8List> dataStream, String id) async {
    final coverImageRef = FirebaseStorage.instance
        .ref()
        .child('events')
        .child(id)
        .child('cover_image.jpg');
    final data = await dataStream;
    await coverImageRef.putData(data);
    final eventRef = FirebaseFirestore.instance.collection('events').doc(id);
    await eventRef.update(
      {
        'coverImageUrl': await coverImageRef.getDownloadURL(),
      },
    );
  }

  Future<void> setData({
    required String eventName,
    required CroppedFile coverImage,
    required DateTime startDate,
    required String city,
    required String description,
    required List<String> tags,
  }) async {
    final eventRef = FirebaseFirestore.instance.collection('events').doc();
    final authorRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final authorUsername = authorRef['username'];
    await eventRef.set(
      {
        'eventName': eventName,
        'eventOrganizer': authorUsername,
        'startDate': startDate,
        'city': city,
        'description': description,
        'tags': tags,
        'dateCreated': DateTime.now(),
      },
    );
    await setCoverImage(coverImage.readAsBytes(), eventRef.id);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getEventFromId(String id) {
    return FirebaseFirestore.instance.collection('events').doc(id).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSortedEventsWithLimit({
    required String field,
    bool isDescending = false,
    required int limit,
  }) async {
    return await FirebaseFirestore.instance
        .collection('events')
        .orderBy(field, descending: isDescending)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getEventsByMonths({
    required String field,
    required int monthNumber,
  }) async {
    final currentYear = DateTime.now().year;
    final start = DateTime(currentYear, monthNumber, 1);
    final end = DateTime(currentYear, monthNumber + 1, 1);
    return await FirebaseFirestore.instance
        .collection('events')
        .where(field, isGreaterThanOrEqualTo: start, isLessThan: end)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getEventsByDate({
    required String field,
    required DateTime date,
  }) async {
    final currentYear = DateTime.now().year;
    final start = DateTime(currentYear, date.month, date.day);
    final end = DateTime(currentYear, date.month, date.day + 1);
    return await FirebaseFirestore.instance
        .collection('events')
        .where(field, isGreaterThanOrEqualTo: start, isLessThan: end)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getEventStreamFromAuthorUsername(
    String authorUsername,
  ) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('authorUsername', isEqualTo: authorUsername)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getEventsStream() {
    return FirebaseFirestore.instance.collection('events').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSortedEventsStream(
      String field,
      {bool isDescending = false}) {
    return FirebaseFirestore.instance
        .collection('events')
        .orderBy(field, descending: isDescending)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getSortedEventsStreamWithEventOrganizer(
    String field, {
    required String eventOrganizer,
    bool isDescending = false,
  }) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('eventOrganizer', isEqualTo: eventOrganizer)
        .orderBy(field, descending: isDescending)
        .snapshots();
  }

  Future<void> updateEventFromId(String id, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('events').doc(id).update(data);
  }

  Future<void> deleteEventsFromId(String id) async {
    await FirebaseFirestore.instance.collection('events').doc(id).delete();
  }
}
