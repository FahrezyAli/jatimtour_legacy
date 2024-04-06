import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Text text;
  final Color color;
  final void Function()? onTap;

  final double radius = kIsWeb ? 30.0 : 20.0;

  const CircleButton(
      {required this.text,
      required this.color,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius),
      color: Colors.white,
      elevation: 10.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: color,
          ),
          height: kIsWeb ? 50.0 : 25.0,
          width: kIsWeb ? 175.0 : 115.0,
          child: Center(child: text),
        ),
      ),
    );
  }
}
