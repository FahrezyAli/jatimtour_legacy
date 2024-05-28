import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/web/pages/web_scaffold.dart';

class ProfilePageWeb extends StatelessWidget {
  const ProfilePageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final userInstance = Modular.get<UserModel>();
    return WebScaffold(
      body: ListView(
        children: [
          Image.asset(
            'assets/images/leading.png',
            height: 10.0,
            width: MediaQuery.sizeOf(context).width,
            repeat: ImageRepeat.repeatX,
          ),
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: CircleAvatar(
                    radius: 75.0,
                    backgroundImage: userInstance.getProfilePicture(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    userInstance.userData!['username'],
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    userInstance.authInstance.currentUser!.email!,
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
