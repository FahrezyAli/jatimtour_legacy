import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:universal_html/html.dart' as html;

class SignButton extends StatefulWidget {
  final int state;
  final Function(int state)? onStateChange;

  const SignButton({this.state = 0, required this.onStateChange, super.key});

  @override
  State<SignButton> createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton> {
  late int _state;

  @override
  void initState() {
    super.initState();
    _state = widget.state;
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
                onTap: () {
                  setState(() {
                    _state = 1;
                  });
                  widget.onStateChange!(_state);
                  html.window.history.pushState({}, '', '/login');
                },
                child: _Switch(
                  text: "Log in",
                  state: _state,
                ),
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onTap: () {
                  setState(() {
                    _state = 2;
                  });
                  widget.onStateChange!(_state);
                  html.window.history.pushState({}, '', '/signup');
                },
                child: _Switch(
                  text: "Sign Up",
                  state: _state - 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Switch extends StatelessWidget {
  final String text;
  final int state;

  const _Switch({required this.text, required this.state});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (state != 1) {
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
                color: Color(0xFFF15BF5),
              ),
            ),
          );
        } else {
          return Ink(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFF15BF5),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }
}
