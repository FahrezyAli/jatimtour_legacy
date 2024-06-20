import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../universal/buttons/sign_button.dart';
import '../../universal/carousel/welcome_text_carousel.dart';
import '../../universal/views/login_view.dart';
import '../../universal/views/signup_view.dart';
import '../../universal/views/welcome_view.dart';

class StartPageWeb extends StatefulWidget {
  final int state;

  const StartPageWeb({required this.state, super.key});

  @override
  State<StartPageWeb> createState() => _StartPageWebState();
}

class _StartPageWebState extends State<StartPageWeb> {
  late int _state;

  @override
  void initState() {
    super.initState();
    _state = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Image.asset(
            'assets/images/header.png',
            height: 40.0,
            width: MediaQuery.sizeOf(context).width,
            repeat: ImageRepeat.repeatX,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 150.0),
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: Column(
                  children: [
                    const WelcomeView(),
                    Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: const WelcomeTextCarousel(),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 150.0),
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: Column(
                  children: [
                    SignButton(
                      state: _state,
                      onStateChange: (state) => setState(
                        () {
                          _state = state;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: Builder(
                        builder: (context) {
                          return _state == 1
                              ? FadeInLeft(child: const LoginView())
                              : FadeInRight(child: const SignUpView());
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
