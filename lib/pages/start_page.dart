import 'package:flutter/material.dart';

import '../buttons/login_button.dart';
import '../carousel/welcome_text_carousel.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'welcome_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: Column(
        children: [
          const WelcomePage(),
          Builder(
            builder: (context) {
              if (_state == 0) {
                return Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: const WelcomeTextCarousel(),
                );
              } else {
                return Container();
              }
            },
          ),
          AnimatedPositioned(
            duration: Durations.short4,
            child: Container(
              padding: const EdgeInsets.only(top: 35.0),
              child: LoginButton(
                onStateChange: (int state) => setState(
                  () {
                    _state = state;
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30),
            child: Builder(
              builder: (context) {
                if (_state == 1) {
                  return const LoginPage();
                } else if (_state == 2) {
                  return const SignUpPage();
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
