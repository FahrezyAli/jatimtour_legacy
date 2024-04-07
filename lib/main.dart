import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/firebase_options.dart';
import 'package:jatimtour/widgets/mobile/pages/start_page_mobile.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/web/pages/home_page_web.dart';
import 'package:jatimtour/widgets/web/pages/regis_page_web.dart';
import 'package:jatimtour/widgets/web/pages/start_page_web.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(
          create: (context) => UserModel(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) =>
              kIsWeb ? const HomePageWeb() : const StartPageMobile(),
          '/login': (context) => const StartPageWeb(state: 1),
          '/signup': (context) => const StartPageWeb(state: 2),
          '/regis': (context) => const RegistrationPageWeb(),
        },
        initialRoute: '/',
      ),
    );
  }
}
