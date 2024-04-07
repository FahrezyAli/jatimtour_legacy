import 'package:flutter/material.dart';

class CalenderTile extends StatelessWidget {
  final String month;
  final Widget image;

  const CalenderTile({required this.month, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Row(
        children: [
          image,
          Container(
            padding: const EdgeInsets.only(left: 10.0, top: 7.0),
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: month,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 25.0,
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
