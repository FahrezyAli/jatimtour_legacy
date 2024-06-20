import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../universal/views/change_password_view.dart';
import 'mobile_scaffold.dart';

class ChangePasswordPageMobile extends StatelessWidget {
  const ChangePasswordPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: const [ChangePasswordView()],
      ),
    );
  }
}
