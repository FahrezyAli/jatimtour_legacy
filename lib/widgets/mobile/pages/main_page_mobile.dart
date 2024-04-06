import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/widgets/mobile/pages/calender_page_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/home_page_mobile.dart';
import 'package:jatimtour/widgets/pages/profile_page.dart';

class MainPageMobile extends StatefulWidget {
  const MainPageMobile({super.key});

  @override
  State<MainPageMobile> createState() => _MainPageMobileState();
}

class _MainPageMobileState extends State<MainPageMobile> {
  int _state = 0;
  Color backgroundColor = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
        0 => const HomePageMobile(),
        1 => CalenderPageMobile(),
        4 => const ProfilePage(),
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

  void _getColorFromState(int state) {
    switch (state) {
      case 0:
        backgroundColor = const Color(0xFFE8E0E0);
        break;
      case 1:
        backgroundColor = const Color(0xFFF3F3F3);
        break;
      case 2:
        backgroundColor = const Color(0xFFE8E0E0);
        break;
      case 3:
        backgroundColor = const Color(0xFFE8E0E0);
        break;
      case 4:
        backgroundColor = const Color(0xFFFFFFFF);
        break;
      default:
        backgroundColor = const Color(0xFFFFFFFF);
    }
  }
}
