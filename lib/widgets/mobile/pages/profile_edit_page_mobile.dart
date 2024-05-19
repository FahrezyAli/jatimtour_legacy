import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/mobile/pages/mobile_scaffold.dart';
import 'package:jatimtour/widgets/views/profile_edit_view.dart';

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
          FutureBuilder(
              future: context.read<UserModel>().getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ProfileEditView(data: snapshot.data!.data()!);
                } else {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height - 30.0,
                    width: MediaQuery.sizeOf(context).width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
