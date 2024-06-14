import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/mobile/pages/mobile_scaffold.dart';
import 'package:jatimtour/widgets/mobile/views/calendar_view_mobile.dart';
import 'package:jatimtour/widgets/mobile/views/home_view_mobile.dart';
import 'package:jatimtour/widgets/mobile/views/profile_view_mobile.dart';
import 'package:jatimtour/widgets/mobile/views/search_view_mobile.dart';
import 'package:jatimtour/widgets/mobile/views/your_article_view_mobile.dart';

class MainPageMobileModule extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const MainPageMobile(),
      transition: TransitionType.fadeIn,
      children: [
        ChildRoute(
          '/0',
          child: (context) => const HomeViewMobile(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute(
          '/1',
          child: (context) => const CalendarViewMobile(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute(
          '/2',
          child: (context) => const YourArticleViewMobile(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute(
          '/3',
          child: (context) => const SearchViewMobile(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute(
          '/4',
          child: (context) => const ProfileViewMobile(),
          transition: TransitionType.fadeIn,
        ),
      ],
    );
  }
}

class MainPageMobile extends StatefulWidget {
  const MainPageMobile({super.key});

  @override
  State<MainPageMobile> createState() => _MainPageMobileState();
}

class _MainPageMobileState extends State<MainPageMobile> {
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: CurvedNavigationBar(
        index: _state,
        backgroundColor: Colors.white,
        color: kPurpleColor,
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.date_range, color: Colors.white),
          Icon(Icons.add, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        onTap: (state) {
          Modular.to.navigate('$mHomeRoute/$state');
          setState(() => _state = state);
        },
      ),
    );
  }
}
