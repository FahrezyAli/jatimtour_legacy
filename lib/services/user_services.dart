import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../constants.dart';
import '../models/user_model.dart';

final _authInstance = FirebaseAuth.instance;
final _storageInstance = FirebaseStorage.instance.ref().child('users');
final _firestoreInstance =
    FirebaseFirestore.instance.collection('users').withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (user, _) => user.toMap(),
        );

UserModel? currentUser;

Future<void> signIn({required String email, required String password}) async {
  try {
    await _authInstance.createUserWithEmailAndPassword(
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

Future<void> logIn({required String email, required String password}) async {
  try {
    await _authInstance.signInWithEmailAndPassword(
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
  await getUser(_authInstance.currentUser!.uid).then((user) {
    currentUser = user.data();
  });
}

Future<void> register({
  required String username,
  required String fullName,
  required String phoneNumber,
  required String city,
  required Uint8List? profilePicture,
}) async {
  final user = _authInstance.currentUser;
  final userRef = _firestoreInstance.doc(user!.uid);
  currentUser = UserModel(
    id: user.uid,
    email: user.email!,
    username: username,
    fullName: fullName,
    phoneNumber: phoneNumber,
    city: city,
    role: 0,
    followedEventsId: [],
  );
  final profilePictureRef =
      _storageInstance.child(user.uid).child('profile_picture.jpg');
  if (profilePicture != null) {
    await profilePictureRef.putData(profilePicture);
    final photoUrl = await profilePictureRef.getDownloadURL();
    currentUser!.updatePhotoUrl(photoUrl);
  }
  await userRef.set(currentUser!);
}

Future<void> sendVerificationEmail() async {
  _authInstance.currentUser!.sendEmailVerification();
}

void checkEmailVerified(void Function(bool isVerified) callback) async {
  if (_authInstance.currentUser != null) {
    await _authInstance.currentUser!.reload();
    callback(_authInstance.currentUser!.emailVerified);
  }
}

Future<void> changePassword(
    {required String oldPassword, required String newPassword}) async {
  try {
    await _authInstance.signInWithEmailAndPassword(
      email: _authInstance.currentUser!.email!,
      password: oldPassword,
    );
    await _authInstance.currentUser!.updatePassword(newPassword);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'wrong-password') {
      throw 'Wrong password provided for that user.';
    } else {
      rethrow;
    }
  } catch (e) {
    rethrow;
  }
}

bool isSignedIn() {
  return currentUser != null;
}

Future<void> signOut() async {
  currentUser = null;
  await _authInstance.signOut();
}

Future<void> autoLogin() async {
  if (_authInstance.currentUser != null) {
    await getUser(_authInstance.currentUser!.uid).then((user) {
      currentUser = user.data();
    });
    if (currentUser != null && !kIsWeb) {
      Modular.to.navigate('$mHomeRoute/0');
    }
  }
}

Future<bool> waitAutoLoginFinish() async {
  while (currentUser == null) {
    await Future.delayed(const Duration(milliseconds: 100));
  }
  return true;
}

Future<DocumentSnapshot<UserModel>> getUser(String id) {
  return _firestoreInstance.doc(id).get();
}

Future<List<String>> getUsedUsername() {
  return _firestoreInstance.get().then(
      (value) => value.docs.map((e) => e.data().username.toString()).toList());
}

Stream<QuerySnapshot<UserModel>> getSortedUsersStream(
  String field, {
  bool isDescending = false,
}) {
  return _firestoreInstance
      .orderBy(field, descending: isDescending)
      .snapshots();
}

Future<void> updateUser(
  String id, {
  required String username,
  required String fullName,
  required String phoneNumber,
  required String city,
  Uint8List? profilePicture,
}) async {
  final userRef = _firestoreInstance.doc(id);
  final userData = {
    'username': username,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'city': city,
  };
  final profilePictureRef =
      _storageInstance.child(id).child('profile_picture.jpg');
  if (profilePicture != null) {
    await profilePictureRef.putData(profilePicture);
    userData['photoUrl'] = await profilePictureRef.getDownloadURL();
    currentUser!.updatePhotoUrl(userData['photoUrl']!);
  }
  await userRef.update(userData);
  currentUser!.updateUser(
    username: username,
    fullName: fullName,
    phoneNumber: phoneNumber,
    city: city,
  );
}

Future<void> updateProfilePicture(String id,
    {required Uint8List profilePicture}) async {
  final userRef = _firestoreInstance.doc(currentUser!.id);
  final profilePictureRef =
      _storageInstance.child(currentUser!.id).child('profile_picture.jpg');
  await profilePictureRef.putData(profilePicture);
  final photoUrl = await profilePictureRef.getDownloadURL();
  await userRef.update({'photoUrl': photoUrl});
  currentUser!.updatePhotoUrl(photoUrl);
}

Future<void> updateRole(String id, {required int role}) async {
  final userRef = _firestoreInstance.doc(id);
  await userRef.update({'role': role});
  currentUser!.updateRole(role);
}

Future<void> updateFollowedEvents(
  String id, {
  required String followedEventId,
}) async {
  final userRef = _firestoreInstance.doc(id);
  await userRef.update({
    'followedEventsId': FieldValue.arrayUnion([followedEventId]),
  });
  currentUser!.updateFollowedEvents(followedEventId);
}
