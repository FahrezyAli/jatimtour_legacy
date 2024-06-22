import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';

class CalendarCardWeb extends StatelessWidget {
  final String month;
  final Widget image;

  const CalendarCardWeb({required this.month, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Modular.to.pushNamed('$eventListRoute/$month'),
          child: Ink(
            height: 100.0,
            child: Row(
              children: [
                image,
                Container(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: month,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
