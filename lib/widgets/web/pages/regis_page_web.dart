import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/universal/carousel/welcome_text_carousel.dart';
import 'package:jatimtour/widgets/universal/views/regis_view.dart';
import 'package:jatimtour/widgets/universal/views/welcome_view.dart';

class RegistrationPageWeb extends StatelessWidget {
  const RegistrationPageWeb({super.key});

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
                padding: const EdgeInsets.only(top: 50.0),
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
                padding: const EdgeInsets.only(top: 20.0),
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: const RegistrationView(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
