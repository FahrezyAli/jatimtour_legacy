import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalenderHomePage extends StatelessWidget {
  const CalenderHomePage({super.key});

  final double padding = kIsWeb ? 50.0 : 10.0;
  final double size = kIsWeb ? 350.0 : 100.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              height: size,
              width: size,
              child: Image.asset(
                'assets/images/january.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: padding),
          child: Stack(
            children: [
              SizedBox(
                height: size,
                width: size,
                child: Image.asset(
                  'assets/images/february.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: padding),
          child: Stack(
            children: [
              SizedBox(
                height: size,
                width: size,
                child: Image.asset(
                  'assets/images/maret.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
