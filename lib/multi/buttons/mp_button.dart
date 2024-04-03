import 'package:flutter/material.dart';

class MPButton extends StatelessWidget {
  final Text text;
  final Color color;
  final void Function()? onTap;

  const MPButton(
      {required this.text,
      required this.color,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: color,
          ),
          height: 25.0,
          width: 115.0,
          child: Center(child: text),
        ),
      ),
    );
  }
}
