import 'package:flutter/material.dart';
import 'package:jatimtour/services/user_services.dart' as user_services;
import 'package:jatimtour/widgets/web/pages/web_scaffold.dart';

class ProfilePageWeb extends StatelessWidget {
  const ProfilePageWeb({super.key});

  @override
  Widget build(BuildContext context) {
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
                      backgroundImage:
                          user_services.currentUser!.getProfilePicture()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    user_services.currentUser!.username,
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    user_services.currentUser!.email,
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
