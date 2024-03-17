import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.0,
          width: MediaQuery.sizeOf(context).width,
          child: const Positioned.fill(
            child: Image(
              image: AssetImage('assets/images/header.png'),
              repeat: ImageRepeat.repeatX,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 100.0),
          height: 300.0,
          width: 300.0,
          child: const Center(
            child: Image(image: AssetImage('assets/images/logo.png')),
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
