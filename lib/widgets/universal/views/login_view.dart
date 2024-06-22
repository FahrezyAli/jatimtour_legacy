import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';
import '../../../services/user_services.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isVisible = false;

  void _logIn() {
    if (!EmailValidator.validate(_emailController.text, true)) {
      _showErrorSnackBar("Email is not valid");
    } else {
      logIn(
        email: _emailController.text,
        password: _passwordController.text,
      ).then(
        (value) {
          Modular.to.navigate(kIsWeb ? rootRoute : mHomeRoute);
        },
      ).catchError(
        (e) {
          _showErrorSnackBar(e.toString());
        },
      );
    }
  }

  void _showErrorSnackBar(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Login Error: $error",
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _suffixPasswordIcon() {
    return Focus(
      canRequestFocus: false,
      descendantsAreFocusable: false,
      child: IconButton(
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
            height: 40.0,
            width: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "email",
                  hintStyle: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.0,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14.0,
                ),
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
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
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_isVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "password",
                    hintStyle: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14.0,
                    ),
                    suffixIcon: _suffixPasswordIcon(),
                  ),
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.0,
                  ),
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) => _logIn(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: RichText(
              text: TextSpan(
                text: "Log in →",
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20.0,
                  decoration: TextDecoration.underline,
                  color: Color(0xFFF15BF5),
                ),
                recognizer: TapGestureRecognizer()..onTap = () => _logIn(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
