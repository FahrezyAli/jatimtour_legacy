import 'package:firebase_auth/firebase_auth.dart';

class Users {
  late int id;
  late String name;
  late String username;
  String email;
  late String password;
  late DateTime birthDate;
  bool adminStatus = false;
  late UserCredential credential;

  Users({
    required this.email,
    required this.password,
  });

  signIn() async {
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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

  logIn() async {
    try {
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
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
}
