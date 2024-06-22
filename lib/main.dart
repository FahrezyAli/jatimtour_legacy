import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constants.dart';
import 'firebase_options.dart';
import 'route_guard/profile_guard.dart';
import 'services/user_services.dart';
import 'widgets/mobile/pages/article_page_mobile.dart';
import 'widgets/mobile/pages/change_password_page_mobile.dart';
import 'widgets/mobile/pages/create_article_page_mobile.dart';
import 'widgets/mobile/pages/event_list_page_mobile.dart';
import 'widgets/mobile/pages/event_list_page_with_date_mobile.dart';
import 'widgets/mobile/pages/event_list_page_with_location.dart';
import 'widgets/mobile/pages/event_page_mobile.dart';
import 'widgets/mobile/pages/main_page_mobile.dart';
import 'widgets/mobile/pages/profile_edit_page_mobile.dart';
import 'widgets/mobile/pages/regis_page_mobile.dart';
import 'widgets/mobile/pages/start_page_mobile.dart';
import 'widgets/mobile/pages/update_article_page_mobile.dart';
import 'widgets/web/pages/article_page_web.dart';
import 'widgets/web/pages/calendar_page_web.dart';
import 'widgets/web/pages/change_password_page_web.dart';
import 'widgets/web/pages/create_article_page_web.dart';
import 'widgets/web/pages/create_event_page_web.dart';
import 'widgets/web/pages/home_page_web.dart';
import 'widgets/web/pages/profile_page_web.dart';
import 'widgets/web/pages/regis_page_web.dart';
import 'widgets/web/pages/search_page_web.dart';
import 'widgets/web/pages/start_page_web.dart';

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
    autoLogin();
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
      r.child(
        rootRoute,
        child: (context) => const HomePageWeb(),
        transition: TransitionType.fadeIn,
      );
      r.child(
        loginRoute,
        child: (context) => const StartPageWeb(state: 1),
        transition: TransitionType.fadeIn,
      );
      r.child(
        regisRoute,
        child: (context) => const RegistrationPageWeb(),
        transition: TransitionType.fadeIn,
      );
      r.child(
        articleRoute,
        child: (context) => ArticlePageWeb(
          articleId: r.args.queryParams['articleId']!,
        ),
        transition: TransitionType.fadeIn,
      );
      r.child(
        createArticleRoute,
        child: (context) => const CreateArticlePageWeb(),
        transition: TransitionType.fadeIn,
      );
      r.child(
        searchRoute,
        child: (context) => const SearchPageWeb(),
        transition: TransitionType.fadeIn,
      );
      r.child(
        calendarRoute,
        child: (context) => const CalendarPageWeb(),
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
        '$eventListRoute/:month',
        child: (context) => EventListPageMobile(
          month: r.args.params['month'],
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
        eventListRouteWithLocation,
        child: (context) => EventListPageWithLocationMobile(
          location: r.args.queryParams['location']!,
        ),
        transition: TransitionType.fadeIn,
      );
      r.child(
        createEventRoute,
        child: (context) => const CreateEventPageWeb(),
        transition: TransitionType.fadeIn,
      );
      r.module(
        profileRoute,
        module: ProfilePageWebModule(),
        transition: TransitionType.fadeIn,
        guards: [ProfileGuard()],
      );
      r.child(
        changePasswordRoute,
        child: (context) => const ChangePasswordPageWeb(),
        transition: TransitionType.fadeIn,
      );
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
        '$eventListRoute/:month',
        child: (context) => EventListPageMobile(
          month: r.args.params['month'],
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
        eventListRouteWithLocation,
        child: (context) => EventListPageWithLocationMobile(
          location: r.args.queryParams['location']!,
        ),
        transition: TransitionType.fadeIn,
      );
      r.child(
        editProfileRoute,
        child: (context) => const ProfileEditPageMobile(),
        transition: TransitionType.fadeIn,
      );
      r.child(
        changePasswordRoute,
        child: (context) => const ChangePasswordPageMobile(),
        transition: TransitionType.fadeIn,
      );
    }
  }
}
