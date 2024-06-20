import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';
import '../../../services/user_services.dart' as user_services;
import '../buttons/circle_button.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _retypeNewPasswordController = TextEditingController();

  bool _oldIsVisible = false;
  bool _newIsVisible = false;

  Future<void> _changePassword() async {
    if (_oldPasswordController.text == "" ||
        _newPasswordController.text == "" ||
        _retypeNewPasswordController.text == "") {
      _showErrorSnackBar("Please fill all the fields");
    } else if (_newPasswordController.text.length < 6) {
      _showErrorSnackBar("Password must be at least 6 characters");
    } else if (_newPasswordController.text !=
        _retypeNewPasswordController.text) {
      _showErrorSnackBar("New password doesn't match");
    } else {
      await user_services
          .changePassword(
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
      )
          .catchError(
        (e) {
          _showErrorSnackBar(e.toString());
        },
      );
      Modular.to.pop();
    }
  }

  void _showErrorSnackBar(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _suffixOldPasswordIcon() {
    return Focus(
      canRequestFocus: false,
      descendantsAreFocusable: false,
      child: IconButton(
        icon: Icon(
          _oldIsVisible ? Icons.visibility : Icons.visibility_off,
          color: const Color(0xFFF15BF5),
        ),
        onPressed: () => setState(
          () {
            _oldIsVisible = !_oldIsVisible;
          },
        ),
      ),
    );
  }

  Widget _suffixNewPasswordIcon() {
    return Focus(
      canRequestFocus: false,
      descendantsAreFocusable: false,
      child: IconButton(
        icon: Icon(
          _newIsVisible ? Icons.visibility : Icons.visibility_off,
          color: const Color(0xFFF15BF5),
        ),
        onPressed: () => setState(
          () {
            _newIsVisible = !_newIsVisible;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _newPasswordController.dispose();
    _oldPasswordController.dispose();
    _retypeNewPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(
                "Update Password",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: UnconstrainedBox(
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
                    controller: _oldPasswordController,
                    obscureText: !_oldIsVisible,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Old Password",
                      hintStyle: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                      suffixIcon: _suffixOldPasswordIcon(),
                    ),
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14.0,
                    ),
                    autofillHints: const [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: UnconstrainedBox(
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
                    controller: _newPasswordController,
                    obscureText: !_newIsVisible,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "New Password",
                      hintStyle: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                      suffixIcon: _suffixNewPasswordIcon(),
                    ),
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14.0,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: UnconstrainedBox(
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
                    controller: _retypeNewPasswordController,
                    obscureText: !_newIsVisible,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Retype New Password",
                      hintStyle: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                      suffixIcon: _suffixNewPasswordIcon(),
                    ),
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14.0,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) async {
                      await _changePassword();
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: UnconstrainedBox(
              child: CircleButton(
                text: const Text(
                  "Simpan",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                color: kPinkColor,
                height: 25.0,
                width: 115.0,
                onTap: () async {
                  await _changePassword();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
