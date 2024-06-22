import 'package:flutter_modular/flutter_modular.dart';

import '../services/user_services.dart';

class RoleGuard extends RouteGuard {
  final int role;

  RoleGuard({required this.role});

  @override
  Future<bool> canActivate(String path, ModularRoute route) {
    if (currentUser!.role >= role) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
