import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/firebase_options.dart';
import 'package:jatimtour/services/user_services.dart' as user_services;
import 'package:jatimtour/widgets/mobile/pages/article_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/create_article_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/event_list_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/event_list_page_with_date_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/event_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/main_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/profile_edit_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/regis_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/start_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/update_article_page_mobile.dart';
import 'package:jatimtour/widgets/web/pages/admin_page_web.dart';
import 'package:jatimtour/widgets/web/pages/article_page_web.dart';
import 'package:jatimtour/widgets/web/pages/calendar_page_web.dart';
import 'package:jatimtour/widgets/web/pages/create_article_page_web.dart';
import 'package:jatimtour/widgets/web/pages/create_event_page_web.dart';
import 'package:jatimtour/widgets/web/pages/event_organizer_page.dart';
import 'package:jatimtour/widgets/web/pages/home_page_web.dart';
import 'package:jatimtour/widgets/web/pages/profile_page_web.dart';
import 'package:jatimtour/widgets/web/pages/regis_page_web.dart';
import 'package:jatimtour/widgets/web/pages/start_page_web.dart';
import 'package:jatimtour/widgets/web/pages/your_article_page_web.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  await initializeDateFormatting();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    user_services.autoLogin();
    return MaterialApp.router(
      title: 'JatimTour',
      routerConfig: Modular.routerConfig,
    );
  }
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    if (kIsWeb) {
      r.child(rootRoute, child: (context) => const HomePageWeb());
      r.child(loginRoute, child: (context) => const StartPageWeb(state: 1));
      r.child(signupRoute, child: (context) => const StartPageWeb(state: 2));
      r.child(regisRoute, child: (context) => const RegistrationPageWeb());
      r.child(yourArticleRoute, child: (context) => const YourArticlePageWeb());
      r.child(
        articleRoute,
        child: (context) => ArticlePageWeb(
          articleId: r.args.queryParams['articleId']!,
        ),
      );
      r.child(
        createArticleRoute,
        child: (context) => const CreateArticlePageWeb(),
      );
      r.child(calendarRoute, child: (context) => CalendarPageWeb());
      r.child(
        '$eventListRoute/:month',
        child: (context) => EventListPageMobile(month: r.args.params['month']),
      );
      r.child(
        createEventRoute,
        child: (context) => const CreateEventPageWeb(),
      );
      r.child(eventAdminRoute, child: (context) => const EventOrganizerView());
      r.child(profileRoute, child: (context) => const ProfilePageWeb());
      r.child(adminRoute, child: (context) => const AdminPageWeb());
    } else {
      r.child(
        rootRoute,
        child: (context) => const StartPageMobile(),
        transition: TransitionType.fadeIn,
      );
      r.child(
        regisRoute,
        child: (context) => const RegistrationPageMobile(),
        transition: TransitionType.fadeIn,
      );
      r.module(
        mHomeRoute,
        module: MainPageMobileModule(),
        transition: TransitionType.fadeIn,
      );
      r.child(
        articleRoute,
        child: (context) => ArticlePageMobile(
          articleId: r.args.queryParams['articleId']!,
        ),
        transition: TransitionType.fadeIn,
      );
      r.child(
        createArticleRoute,
        child: (context) => const CreateArticlePageMobile(),
        transition: TransitionType.fadeIn,
      );
      r.child(
        updateArticleRoute,
        child: (context) => UpdateArticlePageMobile(
          articleId: r.args.queryParams['articleId']!,
        ),
        transition: TransitionType.fadeIn,
      );
      r.child(
        eventRoute,
        child: (context) => EventPageMobile(
          eventId: r.args.queryParams['eventId']!,
        ),
        transition: TransitionType.fadeIn,
      );
      r.child(
        eventListRoute,
        child: (context) => EventListPageWithDateMobile(
          date: r.args.queryParams['date']!,
        ),
        transition: TransitionType.fadeIn,
      );
      r.child(
        '$eventListRoute/:month',
        child: (context) => EventListPageMobile(
          month: r.args.params['month'],
        ),
        transition: TransitionType.fadeIn,
      );
      r.child(
        editProfileRoute,
        child: (context) => const ProfileEditPageMobile(),
        transition: TransitionType.fadeIn,
      );
    }
  }
}
