import 'package:flutter/material.dart';

class BoxButton extends StatelessWidget {
  final Text text;
  final Color color;
  final void Function()? onTap;

  const BoxButton(
      {required this.text,
      required this.color,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 10.0,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          color: color,
          height: 50.0,
          width: 500.0,
          child: Center(child: text),
        ),
      ),
    );
  }
}
