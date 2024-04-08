import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/web/drawer/home_page_drawer_web.dart';

class WebScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? body;

  const WebScaffold({this.backgroundColor, this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: kPinkColor,
        title: const Text(
          "JATIMTOUR",
          style: TextStyle(
            fontFamily: "KronaOne",
            fontSize: 30.0,
          ),
        ),
      ),
      endDrawer: const HomePageDrawerWeb(),
      body: body,
    );
  }
}
