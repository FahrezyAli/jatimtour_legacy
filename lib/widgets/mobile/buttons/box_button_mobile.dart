import 'package:flutter/material.dart';

class BoxButtonMobile extends StatelessWidget {
  final Text text;
  final Color color;
  final void Function()? onTap;

  const BoxButtonMobile({
    required this.text,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(5.0),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 25.0,
          width: 75.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(child: text),
        ),
      ),
    );
  }
}
