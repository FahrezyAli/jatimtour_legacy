import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/mobile/views/calendar_view_mobile.dart';
import 'package:jatimtour/widgets/mobile/views/home_view_mobile.dart';
import 'package:jatimtour/widgets/mobile/views/profile_view_mobile.dart';

class MainPageMobile extends StatefulWidget {
  const MainPageMobile({super.key});

  @override
  State<MainPageMobile> createState() => _MainPageMobileState();
}

class _MainPageMobileState extends State<MainPageMobile> {
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getColorFromState(_state),
      appBar: AppBar(
        title: const Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "JATIMTOUR",
                style: TextStyle(
                  fontFamily: "KronaOne",
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0x809747FF),
      ),
      body: switch (_state) {
        0 => const HomeViewMobile(),
        1 => CalendarViewMobile(),
        4 => const ProfileViewMobile(),
        _ => null,
      },
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.date_range, color: Colors.white),
          Icon(Icons.add, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        onTap: (state) => setState(
          () {
            _state = state;
            _getColorFromState(state);
          },
        ),
      ),
    );
  }

  Color _getColorFromState(int state) {
    switch (state) {
      case 4:
        return kPinkColor;
      default:
        return kBackgroundColor;
    }
  }
}
