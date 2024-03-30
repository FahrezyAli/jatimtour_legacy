import 'package:flutter/material.dart';

class MPButton extends StatelessWidget {
  final Widget child;

  const MPButton({required Widget this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          height: 25.0,
          width: 115.0,
          child: Center(child: child),
        ),
      ),
    );
  }
}
