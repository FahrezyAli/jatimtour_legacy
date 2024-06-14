import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/services/user_services.dart' as user_services;
import 'package:jatimtour/widgets/mobile/pages/mobile_scaffold.dart';
import 'package:jatimtour/widgets/universal/views/profile_edit_view.dart';

class ProfileEditPageMobile extends StatelessWidget {
  const ProfileEditPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: [
          Image.asset(
            'assets/images/leading.png',
            repeat: ImageRepeat.repeatX,
          ),
          ProfileEditView(data: user_services.currentUser!.toMap()),
        ],
      ),
    );
  }
}
