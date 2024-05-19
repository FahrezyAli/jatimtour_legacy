import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Text text;
  final Color color;
  final radius = kIsWeb ? 30.0 : 20.0;
  final double height;
  final double width;
  final double elevation;
  final BoxBorder? border;
  final void Function()? onTap;

  const CircleButton(
      {required this.text,
      required this.color,
      required this.onTap,
      this.height = kIsWeb ? 50.0 : 25.0,
      this.width = kIsWeb ? 175.0 : 115.0,
      this.elevation = 10.0,
      this.border,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius),
      color: Colors.white,
      elevation: elevation,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            border: border,
            borderRadius: BorderRadius.circular(radius),
            color: color,
          ),
          height: height,
          width: width,
          child: Center(child: text),
        ),
      ),
    );
  }
}
