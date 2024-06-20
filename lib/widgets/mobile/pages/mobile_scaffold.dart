import 'package:flutter/material.dart';

import '../../../constants.dart';

class MobileScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;

  const MobileScaffold({
    this.backgroundColor,
    this.body,
    this.bottomNavigationBar,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPinkColor,
        title: const Text(
          "JATIMTOUR",
          style: TextStyle(
            fontFamily: "KronaOne",
            fontSize: 15.0,
          ),
        ),
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
