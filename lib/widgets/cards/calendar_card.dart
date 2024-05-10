import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalendarCard extends StatelessWidget {
  final String month;
  final Widget image;

  const CalendarCard({required this.month, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kIsWeb ? 300.0 : 100.0,
      margin: const EdgeInsets.only(
        top: 30.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Row(
        children: [
          image,
          Container(
            padding: kIsWeb
                ? const EdgeInsets.only(left: 30.0, top: 80.0)
                : const EdgeInsets.only(left: 10.0, top: 10.0),
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: month,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: kIsWeb ? 40.0 : 20.0,
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
