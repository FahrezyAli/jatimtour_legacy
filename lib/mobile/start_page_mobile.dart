import 'package:flutter/material.dart';
import 'package:jatimtour/mobile/buttons/sign_button_mob.dart';
import 'package:jatimtour/mobile/welcome_page_mobile.dart';
import 'package:jatimtour/multi/carousel/welcome_text_carousel.dart';
import 'package:jatimtour/multi/pages/login_page.dart';
import 'package:jatimtour/multi/pages/signup_page.dart';

class StartPageMobile extends StatefulWidget {
  const StartPageMobile({super.key});

  @override
  State<StartPageMobile> createState() => _StartPageMobileState();
}

class _StartPageMobileState extends State<StartPageMobile> {
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
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
          Container(
            padding: const EdgeInsets.only(top: 35.0),
            child: SignButtonMob(
              onStateChange: (int state) => setState(
                () {
                  _state = state;
                },
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
