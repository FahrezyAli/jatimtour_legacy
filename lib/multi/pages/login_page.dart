import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/multi/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;

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
          child: TextField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 8.0, left: 17.0),
              border: InputBorder.none,
              hintText: "email",
              hintStyle: TextStyle(
                fontFamily: "Inter",
                fontSize: 20.0,
              ),
            ),
            style: const TextStyle(
              fontFamily: "Inter",
              fontSize: 20.0,
            ),
            textInputAction: TextInputAction.next,
            onChanged: (email) => setState(
              () {
                _email = email;
              },
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
              onChanged: (password) => setState(
                () {
                  _password = password;
                },
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
          padding: const EdgeInsets.only(top: 60.0),
          child: RichText(
            text: TextSpan(
                text: "Log in ->",
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20.0,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {}),
          ),
        )
      ],
    );
  }
}
