import 'package:flutter/material.dart';

class CalenderTile extends StatelessWidget {
  final String month;
  final Widget image;

  const CalenderTile({required this.month, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      margin: const EdgeInsets.only(
        top: 30.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Row(
        children: [
          image,
          Container(
            padding: const EdgeInsets.only(left: 30.0, top: 80.0),
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: month,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 40.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
