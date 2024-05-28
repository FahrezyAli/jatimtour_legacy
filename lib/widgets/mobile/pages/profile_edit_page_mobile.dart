import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/mobile/pages/mobile_scaffold.dart';
import 'package:jatimtour/widgets/universal/views/profile_edit_view.dart';

class ProfileEditPageMobile extends StatelessWidget {
  const ProfileEditPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      body: ListView(
        children: [
          Image.asset(
            'assets/images/leading.png',
            repeat: ImageRepeat.repeatX,
          ),
          ProfileEditView(data: Modular.get<UserModel>().userData!),
        ],
      ),
    );
  }
}
