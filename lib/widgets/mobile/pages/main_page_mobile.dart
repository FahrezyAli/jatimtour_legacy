import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/mobile/pages/mobile_scaffold.dart';
import 'package:jatimtour/widgets/mobile/views/calendar_view_mobile.dart';
import 'package:jatimtour/widgets/mobile/views/home_view_mobile.dart';
import 'package:jatimtour/widgets/mobile/views/profile_view_mobile.dart';
import 'package:jatimtour/widgets/mobile/views/search_view_mobile.dart';
import 'package:jatimtour/widgets/mobile/views/your_article_view_mobile.dart';

class MainPageMobile extends StatefulWidget {
  const MainPageMobile({super.key});

  @override
  State<MainPageMobile> createState() => _MainPageMobileState();
}

class _MainPageMobileState extends State<MainPageMobile>
    with RestorationMixin<MainPageMobile> {
  final _state = RestorableInt(0);

  Color? _getColorFromState(int state) {
    if (state == 4) return kPinkColor;
    return null;
  }

  void _refreshState(int state) {
    setState(() {
      _state.value = state;
      _getColorFromState(state);
    });
  }

  @override
  String get restorationId => 'main_page_state';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_state, 'main_page_state');
  }

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      backgroundColor: _getColorFromState(_state.value),
      body: switch (_state.value) {
        0 => HomeViewMobile(_refreshState),
        1 => const CalendarViewMobile(),
        2 => const YourArticleViewMobile(),
        3 => const SearchViewMobile(),
        4 => const ProfileViewMobile(),
        _ => null,
      },
      bottomNavigationBar: CurvedNavigationBar(
        index: _state.value,
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.date_range, color: Colors.white),
          Icon(Icons.add, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        onTap: (state) => setState(() {
          _state.value = state;
          _getColorFromState(state);
        }),
      ),
    );
  }
}
