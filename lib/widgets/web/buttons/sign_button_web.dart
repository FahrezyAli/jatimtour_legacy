import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';

class SignButtonWeb extends StatelessWidget {
  const SignButtonWeb({super.key});

  Widget _button(String text) {
    return Ink(
      padding: const EdgeInsets.only(left: 5.0, right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: "Inter",
          fontSize: 24,
          color: kPinkColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: kPinkColor,
          ),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onTap: () => Navigator.pushNamed(context, "/login"),
                child: _button("Log in"),
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onTap: () => Navigator.pushNamed(context, "/signup"),
                child: _button("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
