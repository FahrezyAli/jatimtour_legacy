import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../constants.dart';
import '../services/user_services.dart';

class ProfileGuard extends RouteGuard {
  ProfileGuard() : super(redirectTo: loginRoute);

  @override
  Future<bool> canActivate(String path, ModularRoute route) {
    if (FirebaseAuth.instance.currentUser != null) {
      return waitAutoLoginFinish();
    } else {
      return Future.value(false);
    }
  }
}
