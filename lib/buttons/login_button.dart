import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final Function(int state)? onStateChange;

  const LoginButton({super.key, required this.onStateChange});

  @override
  State<StatefulWidget> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFF15BB5),
          ),
        ),
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
              },
              child: Switch(
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
              },
              child: Switch(
                text: "Sign Up",
                state: _state - 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Switch extends StatelessWidget {
  final String text;
  final int state;

  const Switch({super.key, required this.text, required this.state});

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
