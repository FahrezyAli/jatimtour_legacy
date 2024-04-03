import 'package:flutter/material.dart';

class WelcomePageMobile extends StatelessWidget {
  const WelcomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.0,
          width: MediaQuery.sizeOf(context).width,
          child: Positioned.fill(
            child: Image.asset(
              'assets/images/header.png',
              repeat: ImageRepeat.repeatX,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 30.0),
          height: 150.0,
          width: 150.0,
          child: Center(
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 30.0),
          child: const Text(
            "JATIMTOUR",
            style: TextStyle(
              fontFamily: 'KronaOne',
              fontSize: 26.0,
            ),
          ),
        ),
      ],
    );
  }
}
