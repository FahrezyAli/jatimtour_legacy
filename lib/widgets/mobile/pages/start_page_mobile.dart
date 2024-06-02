import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/universal/buttons/sign_button.dart';
import 'package:jatimtour/widgets/universal/views/welcome_view.dart';
import 'package:jatimtour/widgets/universal/carousel/welcome_text_carousel.dart';
import 'package:jatimtour/widgets/universal/views/login_view.dart';
import 'package:jatimtour/widgets/universal/views/signup_view.dart';

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
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        children: [
          Image.asset(
            'assets/images/header.png',
            height: 30.0,
            repeat: ImageRepeat.repeatX,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: WelcomeView(),
          ),
          Builder(
            builder: (context) {
              if (_state == 0) {
                return Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: const WelcomeTextCarousel(),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          Container(
            padding: const EdgeInsets.only(top: 35.0),
            child: SignButton(
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
                          _state == 1 ? const LoginView() : const SignUpView(),
                    );
                  }
                  if (!isUp) {
                    return _state == 1
                        ? FadeInLeft(child: const LoginView())
                        : FadeInRight(child: const SignUpView());
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
