import 'package:flutter/material.dart';
import 'package:jatimtour/mobile/start_page_mobile.dart';

class WelcomePageWeb extends StatefulWidget {
  final int state;

  const WelcomePageWeb(this.state, {super.key});

  @override
  State<WelcomePageWeb> createState() => _WelcomePageWebState();
}

class _WelcomePageWebState extends State<WelcomePageWeb> {
  late int _state;

  @override
  void initState() {
    super.initState();
    _state = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    return const StartPageMobile();
  }
}
