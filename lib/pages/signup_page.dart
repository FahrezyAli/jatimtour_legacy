import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40.0,
          width: 250.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: const TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 8.0, left: 17.0),
              border: InputBorder.none,
              hintText: "email",
              hintStyle: TextStyle(
                fontFamily: "Inter",
                fontSize: 20.0,
              ),
            ),
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 20.0,
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            height: 40.0,
            width: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: TextField(
              obscureText: !_isVisible,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 8.0, left: 17.0),
                hintText: "password",
                hintStyle: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20.0,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFFF15BF5),
                  ),
                  onPressed: () => setState(
                    () {
                      _isVisible = !_isVisible;
                    },
                  ),
                ),
              ),
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            height: 40.0,
            width: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: TextField(
              obscureText: !_isVisible,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 8.0, left: 17.0),
                hintText: "retype password",
                hintStyle: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20.0,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFFF15BF5),
                  ),
                  onPressed: () => setState(
                    () {
                      _isVisible = !_isVisible;
                    },
                  ),
                ),
              ),
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: InkWell(
            child: Ink(
              height: 40.0,
              width: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: const Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image(
                      image: AssetImage('assets/images/google_logo.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Log in with Google",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 20.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.5),
          child: RichText(
            text: TextSpan(
              text: "Sign Up ->",
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 20.0,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ),
        )
      ],
    );
  }
}
