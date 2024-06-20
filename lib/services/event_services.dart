import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/event_model.dart';
import 'user_services.dart' as user_services;

final _storageInstance = FirebaseStorage.instance.ref().child('events');
final _firestoreInstance =
    FirebaseFirestore.instance.collection('events').withConverter(
          fromFirestore: EventModel.fromFirestore,
          toFirestore: (event, _) => event.toMap(),
        );

Future<void> createEvent({
  required String eventName,
  required Uint8List coverImage,
  required DateTime startDate,
  required String city,
  required String description,
  required List<String> tags,
}) async {
  final eventRef = _firestoreInstance.doc();
  final newEvent = EventModel(
    id: eventRef.id,
    eventOrganizerId: user_services.currentUser!.id,
    eventName: eventName,
    startDate: startDate,
    city: city,
    description: description,
    tags: tags,
    coverImageUrl: '',
    dateCreated: DateTime.now(),
  );
  await eventRef.set(newEvent);
  await _setCoverImage(eventRef.id, coverImage);
}

Future<void> _setCoverImage(String id, Uint8List coverImage) async {
  final coverImageRef = _storageInstance.child(id).child('cover_image.jpg');
  await coverImageRef.putData(coverImage);
  final eventRef = _firestoreInstance.doc(id);
  await eventRef.update(
    {
      'coverImageUrl': await coverImageRef.getDownloadURL(),
    },
  );
}

Future<DocumentSnapshot<EventModel>> getEvent(String id) {
  return _firestoreInstance.doc(id).get();
}

Future<QuerySnapshot<EventModel>> getSortedEventsWithLimit({
  required String field,
  bool isDescending = false,
  required int limit,
}) {
  return _firestoreInstance
      .orderBy(field, descending: isDescending)
      .limit(limit)
      .get();
}

Future<QuerySnapshot<EventModel>> getEventsByMonths({
  required int monthNumber,
}) {
  final currentYear = DateTime.now().year;
  final start = DateTime(currentYear, monthNumber, 1);
  final end = DateTime(currentYear, monthNumber + 1, 1);
  return _firestoreInstance
      .where('startDate', isGreaterThanOrEqualTo: start, isLessThan: end)
      .get();
}

Future<QuerySnapshot<EventModel>> getEventsByDate({
  required DateTime date,
}) {
  final currentYear = DateTime.now().year;
  final start = DateTime(currentYear, date.month, date.day);
  final end = DateTime(currentYear, date.month, date.day + 1);
  return _firestoreInstance
      .where('startDate', isGreaterThanOrEqualTo: start, isLessThan: end)
      .get();
}

Future<QuerySnapshot<EventModel>> getEventsByLocation({
  required String location,
}) {
  return _firestoreInstance.where('city', isEqualTo: location).get();
}

Stream<QuerySnapshot<EventModel>> getEventStreamFromAuthorId(
  String authorId,
) {
  return _firestoreInstance.where('authorId', isEqualTo: authorId).snapshots();
}

Stream<QuerySnapshot<EventModel>> getEventsStream() {
  return _firestoreInstance.snapshots();
}

Stream<QuerySnapshot<EventModel>> getSortedEventsStream(
  String field, {
  bool isDescending = false,
}) {
  return _firestoreInstance
      .orderBy(field, descending: isDescending)
      .snapshots();
}

Stream<QuerySnapshot<EventModel>> getSortedEventsStreamWithEventOrganizerId(
  String field, {
  required String eventOrganizerId,
  bool isDescending = false,
}) {
  return _firestoreInstance
      .where('eventOrganizerId', isEqualTo: eventOrganizerId)
      .orderBy(field, descending: isDescending)
      .snapshots();
}

Future<void> updateEvent(String id, Map<String, dynamic> data) async {
  await _firestoreInstance.doc(id).update(data);
}

Future<void> deleteEvent(String id) async {
  await _firestoreInstance.doc(id).delete();
}
