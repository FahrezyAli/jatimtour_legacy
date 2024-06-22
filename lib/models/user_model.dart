import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/image_services.dart';

class UserModel {
  final String id;
  String email;
  String username;
  String fullName;
  String phoneNumber;
  String? photoUrl;
  String city;
  int role;
  List<String> followedEventsId;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.fullName,
    required this.phoneNumber,
    this.photoUrl,
    required this.city,
    this.role = 0,
    required this.followedEventsId,
  });

  void updateUser({
    required String username,
    required String fullName,
    required String phoneNumber,
    required String city,
  }) {
    this.username = username;
    this.fullName = fullName;
    this.phoneNumber = phoneNumber;
    this.city = city;
  }

  void updatePhotoUrl(String photoUrl) {
    this.photoUrl = photoUrl;
  }

  void updateRole(int role) {
    this.role = role;
  }

  void updateFollowedEvents(String followedEventId) {
    followedEventsId.add(followedEventId);
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> data,
    SnapshotOptions? options,
  ) {
    return UserModel(
      id: data.id,
      email: data['email'],
      username: data['username'],
      fullName: data['fullName'],
      phoneNumber: data['phoneNumber'],
      city: data['city'],
      photoUrl: data['photoUrl'],
      role: data['role'],
      followedEventsId: data['followedEventsId'].cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'city': city,
      'photoUrl': photoUrl,
      'role': role,
      'followedEventsId': followedEventsId,
    };
  }

  ImageProvider getProfilePicture() {
    if (photoUrl != null) {
      return NetworkImage(photoUrl!);
    } else {
      return getLocalImage('assets/images/placeholder.png');
    }
  }
}
