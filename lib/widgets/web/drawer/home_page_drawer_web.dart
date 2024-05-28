import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/universal/buttons/circle_button.dart';
import 'package:jatimtour/widgets/web/buttons/sign_button_web.dart';

class HomePageDrawerWeb extends StatelessWidget {
  const HomePageDrawerWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final userInstance = Modular.get<UserModel>();
    final userRole = userInstance.userData != null
        ? Modular.get<UserModel>().userData!['role']
        : 0;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: kPinkColor,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: userInstance.getProfilePicture(),
                ),
                Text(
                  userInstance.userData != null
                      ? userInstance.userData!['username']
                      : "Guest",
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(fontFamily: "Inter"),
            ),
            onTap: () => Modular.to.navigate(rootRoute),
          ),
          ListTile(
            title: const Text(
              "Artikel",
              style: TextStyle(fontFamily: "Inter"),
            ),
            onTap: () => Modular.to.navigate(yourArticleRoute),
          ),
          ListTile(
            title: const Text(
              "Kalender",
              style: TextStyle(fontFamily: "Inter"),
            ),
            onTap: () => Modular.to.navigate(calendarRoute),
          ),
          ListTile(
            title: const Text(
              "Profil",
              style: TextStyle(fontFamily: "Inter"),
            ),
            onTap: () {
              Modular.to.navigate(userInstance.authInstance.currentUser != null
                  ? profileRoute
                  : loginRoute);
            },
          ),
          userRole == 2
              ? ListTile(
                  title: const Text(
                    "Admin",
                    style: TextStyle(fontFamily: "Inter"),
                  ),
                  onTap: () => Modular.to.navigate(adminRoute),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Align(
              alignment: Alignment.center,
              child: Builder(
                builder: (context) {
                  return !userInstance.isSignedIn()
                      ? const SignButtonWeb()
                      : CircleButton(
                          text: const Text(
                            "Log Out",
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                          color: kPinkColor,
                          onTap: () {
                            userInstance.signOut();
                            Modular.to.pop();
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
