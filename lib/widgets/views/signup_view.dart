import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/user_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late String _email;
  late String _password;
  late String _retypedPassword;

  bool _isVisible = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final user = context.read<UserModel>();
      await user.signIn(_email, _password);
      Modular.to.navigate(regisRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                textInputAction: TextInputAction.next,
                validator: (value) => !EmailValidator.validate(value!, true)
                    ? "Not a valid email"
                    : null,
                onSaved: (value) => _email = value!,
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
                    fontSize: 14.0,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value!.length < 6
                      ? "Password must be at least 6 characters"
                      : value != _retypedPassword
                          ? "Passwords do not match"
                          : null,
                  onSaved: (value) => _password = value!,
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
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: TextFormField(
                  obscureText: !_isVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "retype password",
                    hintStyle: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14.0,
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
                    fontSize: 14.0,
                  ),
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => _retypedPassword = value,
                  onFieldSubmitted: (value) async {
                    await _signUp();
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              child: InkWell(
                child: Ink(
                  height: 40.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/images/google_logo.png'),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Log in with Google",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                text: "Sign Up →",
                style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 20.0,
                    decoration: TextDecoration.underline,
                    color: Color(0xFFF15BF5)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await _signUp();
                  },
              ),
            ),
          )
        ],
      ),
    );
  }
}
