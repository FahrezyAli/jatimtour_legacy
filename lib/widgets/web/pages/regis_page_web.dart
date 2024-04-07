import 'package:flutter/material.dart';
import 'package:jatimtour/widgets/carousel/welcome_text_carousel.dart';
import 'package:jatimtour/widgets/pages/regis_page.dart';
import 'package:jatimtour/widgets/pages/welcome_page.dart';

class RegistrationPageWeb extends StatefulWidget {
  const RegistrationPageWeb({super.key});

  @override
  State<RegistrationPageWeb> createState() => _RegistrationPageWebState();
}

class _RegistrationPageWebState extends State<RegistrationPageWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE2),
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
                    const WelcomePage(),
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
                child: const RegistrationPage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
