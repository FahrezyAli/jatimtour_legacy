import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/firebase_options.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/mobile/pages/main_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/profile_edit_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/start_page_mobile.dart';
import 'package:jatimtour/widgets/web/pages/calendar_page_web.dart';
import 'package:jatimtour/widgets/web/pages/home_page_web.dart';
import 'package:jatimtour/widgets/web/pages/profile_page_web.dart';
import 'package:jatimtour/widgets/web/pages/start_page_web.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    if (kIsWeb) {
      r.child(rootRoute, child: (context) => const HomePageWeb());
      r.child(loginRoute, child: (context) => const StartPageWeb(state: 1));
      r.child(signupRoute, child: (context) => const StartPageWeb(state: 2));
      r.child(profileRoute, child: (context) => const ProfilePageWeb());
      r.child(calendarRoute, child: (context) => CalendarPageWeb());
    } else {
      r.child(rootRoute, child: (context) => const StartPageMobile());
      r.child(mHomeRoute, child: (context) => const MainPageMobile());
      r.child(editProfileRoute,
          child: (context) => const ProfileEditPageMobile());
    }
  }
}
