import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';

class ActionButtonWeb extends StatelessWidget {
  final String text;
  final double horizontalPadding;
  final String route;

  const ActionButtonWeb({
    required this.text,
    this.horizontalPadding = 20.0,
    required this.route,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onTap: () => Modular.to.navigate(route),
        child: Ink(
          decoration: BoxDecoration(
            color: kPinkColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 5.0,
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 17.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
