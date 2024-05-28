import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';

class PictureSelectButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const PictureSelectButton(
      {required this.text, required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: SizedBox(
            height: 75.0,
            width: 75.0,
            child: Material(
              color: kPinkColor,
              child: InkWell(
                onTap: onTap,
                child: Icon(
                  icon,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            text,
            style: const TextStyle(fontFamily: "Inter"),
          ),
        ),
      ],
    );
  }
}
