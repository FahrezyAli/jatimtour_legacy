import 'package:builders/builders.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/firebase_options.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/mobile/pages/start_page_mobile.dart';
import 'package:jatimtour/widgets/web/pages/calender_page_web.dart';
import 'package:jatimtour/widgets/web/pages/home_page_web.dart';
import 'package:jatimtour/widgets/web/pages/profile_page_web.dart';
import 'package:jatimtour/widgets/web/pages/start_page_web.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Builders.systemInjector(Modular.get);
  setPathUrlStrategy();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'JatimTour',
      routerConfig: Modular.routerConfig,
    );
  }
}

class AppModule extends Module {
  @override
  void binds(i) {
    i.add(UserModel.new);
  }

  @override
  void routes(r) {
    r.child(homeRoute,
        child: (context) =>
            kIsWeb ? const HomePageWeb() : const StartPageMobile());
    r.child(loginRoute, child: (context) => const StartPageWeb(state: 1));
    r.child(signupRoute, child: (context) => const StartPageWeb(state: 2));
    r.child(profileRoute, child: (context) => const ProfilePageWeb());
    r.child(calenderRoute, child: (context) => CalenderPageWeb());
  }
}
