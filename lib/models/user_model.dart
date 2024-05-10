import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? username;
  String? fullName;
  String? phoneNumber;
  String? city;
  bool adminStatus = false;

  Future<void> signIn(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      }
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> setData(
      String username, String fullName, String city, String phoneNumber) async {
    final user = auth.currentUser;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    await userRef.set(
      {
        'username': username,
        'fullName': fullName,
        'city': city,
        'phoneNumber': phoneNumber,
        'adminStatus': adminStatus,
      },
    );
  }

  Future<void> setProfilePicture(Future<Uint8List> dataStream) async {
    final user = auth.currentUser;
    final profilePictureRef = FirebaseStorage.instance
        .ref()
        .child('users')
        .child(user!.uid)
        .child('profile_picture.jpg');
    final data = await dataStream;
    await profilePictureRef.putData(data);
    await user.updatePhotoURL(await profilePictureRef.getDownloadURL());
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getDataStream() {
    return auth.currentUser != null
        ? FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .snapshots()
        : null;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
  }

  Future<void> updateData(
      String username, String fullName, String city, String phoneNumber) async {
    final user = auth.currentUser;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    await userRef.update(
      {
        'username': username,
        'fullName': fullName,
        'city': city,
        'phoneNumber': phoneNumber,
      },
    );
  }

  ImageProvider<Object> getProfilePicture() {
    return auth.currentUser != null
        ? auth.currentUser!.photoURL != null
            ? Image.network(auth.currentUser!.photoURL!).image
            : const AssetImage('assets/images/placeholder.png')
        : const AssetImage('assets/images/placeholder.png');
  }
}
