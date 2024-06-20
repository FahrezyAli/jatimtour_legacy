import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';
import '../../universal/buttons/circle_button.dart';
import '../../universal/views/profile_edit_view.dart';
import 'mobile_scaffold.dart';

class ProfileEditPageMobile extends StatelessWidget {
  const ProfileEditPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: [
          const ProfileEditView(),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: UnconstrainedBox(
              child: CircleButton(
                text: const Text(
                  "Ubah Password",
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
                onTap: () => Modular.to.pushNamed(changePasswordRoute),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
