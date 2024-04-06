import 'package:flutter/material.dart';

class CalenderHomePage extends StatelessWidget {
  const CalenderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 100.0,
              width: 100.0,
              child: Image.asset('assets/images/january.png'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Stack(
            children: [
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: Image.asset('assets/images/february.png'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Stack(
            children: [
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: Image.asset('assets/images/maret.png'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
