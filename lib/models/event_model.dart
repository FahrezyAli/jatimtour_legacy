import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/user_services.dart' as user_services;

class EventModel {
  final String id;
  final String eventOrganizerId;
  final String eventName;
  final DateTime startDate;
  final String city;
  final String description;
  final List<String> tags;
  final String coverImageUrl;
  final DateTime dateCreated;

  EventModel({
    required this.id,
    required this.eventOrganizerId,
    required this.eventName,
    required this.startDate,
    required this.city,
    required this.description,
    required this.tags,
    required this.coverImageUrl,
    required this.dateCreated,
  });

  factory EventModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> data,
    SnapshotOptions? options,
  ) {
    return EventModel(
      id: data.id,
      eventOrganizerId: data['eventOrganizerId'],
      eventName: data['eventName'],
      startDate: data['startDate'].toDate(),
      city: data['city'],
      description: data['description'],
      tags: List<String>.from(data['tags']),
      coverImageUrl: data['coverImageUrl'],
      dateCreated: data['dateCreated'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventOrganizerId': eventOrganizerId,
      'eventName': eventName,
      'startDate': startDate,
      'city': city,
      'description': description,
      'tags': tags,
      'coverImageUrl': coverImageUrl,
      'dateCreated': dateCreated,
    };
  }

  Future<String> getAuthorUsernameFromAuthorId() {
    return user_services.getUser(eventOrganizerId).then((user) {
      return user.data()!.username;
    });
  }
}
