import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/views/profile_edit_view.dart';

class ProfileEditPageMobile extends StatelessWidget {
  const ProfileEditPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30.0,
            width: MediaQuery.sizeOf(context).width,
            child: Positioned.fill(
              child: Image.asset(
                'assets/images/header.png',
                repeat: ImageRepeat.repeatX,
              ),
            ),
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
