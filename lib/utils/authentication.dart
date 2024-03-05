import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> signup(
  String email,
  String password,
  VoidCallback onSuccess,
  Function(String e) onFailed,
) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      onFailed.call("");
    } else if (e.code == 'email-already-in-use') {
      onFailed.call("");
    }
  } catch (e) {
    onFailed.call("");
  }
  onSuccess.call();
}

Future<void> login(
  String email,
  String password,
  VoidCallback onSuccess,
  Function(String e) onFailed,
) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      onFailed.call("");
    } else if (e.code == 'wrong-password') {
      onFailed.call("");
    }
  } catch (e) {
    onFailed.call("");
  }
  onSuccess.call();
}
