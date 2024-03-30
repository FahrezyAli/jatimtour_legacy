import 'package:flutter/material.dart';

class CalenderHomePage extends StatelessWidget {
  const CalenderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 100.0,
              width: 100.0,
              child: Image(
                image: AssetImage('assets/images/january.png'),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Stack(
            children: [
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: Image(
                  image: AssetImage('assets/images/february.png'),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Stack(
            children: [
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: Image(
                  image: AssetImage('assets/images/maret.png'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
