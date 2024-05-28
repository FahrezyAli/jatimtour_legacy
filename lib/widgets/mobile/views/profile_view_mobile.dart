import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/mobile/buttons/box_button_mobile.dart';

class ProfileViewMobile extends StatelessWidget {
  const ProfileViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final userInstance = Modular.get<UserModel>();
    return Stack(
      children: [
        Positioned.fill(
          top: 122.5,
          child: Container(
            decoration: const BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
          ),
        ),
        Column(
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
              child: Column(
                children: [
                  Text(
                    userInstance.userData!['username'],
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    userInstance.authInstance.currentUser!.email!,
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxButtonMobile(
                    text: const Text(
                      "Edit",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    color: kPurpleColor,
                    onTap: () => Modular.to.pushNamed(editProfileRoute),
                  ),
                  const SizedBox(width: 20.0),
                  BoxButtonMobile(
                    text: const Text(
                      "Sign Out",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    color: kPurpleColor,
                    onTap: () async {
                      await userInstance.signOut();
                      Modular.to.navigate('/');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
