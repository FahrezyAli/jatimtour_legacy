import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/mobile/buttons/sign_button_mob.dart';
import 'package:jatimtour/mobile/pages/welcome_page_mobile.dart';
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
  bool isUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        children: [
          const WelcomePageMobile(),
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
                if (_state != 0) {
                  while (isUp) {
                    isUp = !isUp;
                    return FadeInUp(
                      child:
                          _state == 1 ? const LoginPage() : const SignUpPage(),
                    );
                  }
                  if (!isUp) {
                    return _state == 1
                        ? FadeInLeft(child: const LoginPage())
                        : FadeInRight(child: const SignUpPage());
                  } else {
                    return const SizedBox.shrink();
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
