import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserModel {
  final authInstance = FirebaseAuth.instance;
  Map<String, dynamic>? userData;

  Future<void> signIn(String email, String password) async {
    try {
      await authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
    final userData = await getUserData();
    this.userData = userData.data();
  }

  bool isSignedIn() {
    return authInstance.currentUser != null;
  }

  Future<void> signOut() async {
    await authInstance.signOut();
    Modular.dispose<UserModel>();
  }

  Future<void> setUserData({
    required String username,
    required String fullName,
    required String phoneNumber,
    required String city,
  }) async {
    final userData = {
      'email': authInstance.currentUser!.email,
      'username': username,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'city': city,
      'role': 0,
    };
    this.userData = userData;
    final user = authInstance.currentUser;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    await userRef.set(userData);
  }

  Future<void> setProfilePicture(Future<Uint8List> dataStream) async {
    final user = authInstance.currentUser;
    final profilePictureRef = FirebaseStorage.instance
        .ref()
        .child('users')
        .child(user!.uid)
        .child('profile_picture.jpg');
    final data = await dataStream;
    await profilePictureRef.putData(data);
    await user.updatePhotoURL(await profilePictureRef.getDownloadURL());
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getUserDataStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authInstance.currentUser!.uid)
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authInstance.currentUser!.uid)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSortedUsersStream(String field,
      {bool isDescending = false}) {
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy(field, descending: isDescending)
        .snapshots();
  }

  Future<void> updateUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    final user = authInstance.currentUser;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    await userRef.update(userData);
  }

  Future<void> updateUserDataFromUid(
      String uid, Map<String, dynamic> userData) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    await userRef.update(userData);
  }

  ImageProvider<Object> getProfilePicture() {
    return authInstance.currentUser != null
        ? authInstance.currentUser!.photoURL != null
            ? Image.network(authInstance.currentUser!.photoURL!).image
            : const AssetImage('assets/images/placeholder.png')
        : const AssetImage('assets/images/placeholder.png');
  }
}
