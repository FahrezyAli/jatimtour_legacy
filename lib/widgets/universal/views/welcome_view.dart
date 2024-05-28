import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150.0,
          width: 150.0,
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
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
