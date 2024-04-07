import 'package:flutter/material.dart';
import 'package:jatimtour/widgets/pages/regis_page.dart';

class RegistrationPageMobile extends StatefulWidget {
  const RegistrationPageMobile({super.key});

  @override
  State<RegistrationPageMobile> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE2),
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
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
          const RegistrationPage(),
        ],
      ),
    );
  }
}
