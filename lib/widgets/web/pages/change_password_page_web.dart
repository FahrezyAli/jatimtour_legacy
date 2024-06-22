import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../services/image_services.dart';
import '../../universal/carousel/welcome_text_carousel.dart';
import '../../universal/views/change_password_view.dart';
import '../../universal/views/welcome_view.dart';

class ChangePasswordPageWeb extends StatelessWidget {
  const ChangePasswordPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Image(
            image: getLocalImage('assets/images/header.png'),
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
                child: const ChangePasswordView(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
