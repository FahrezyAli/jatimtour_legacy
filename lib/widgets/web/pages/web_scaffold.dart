import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/web/drawer/home_page_drawer_web.dart';

class WebScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? body;
  final List<Widget>? actions;
  final double horizontalPadding;

  const WebScaffold({
    this.backgroundColor,
    this.body,
    this.actions,
    this.horizontalPadding = 300.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          actions: actions,
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
      ),
    );
  }
}
