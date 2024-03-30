import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/mobile/pages/home_page_mobile.dart';

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
          },
        ),
      ),
    );
  }
}
