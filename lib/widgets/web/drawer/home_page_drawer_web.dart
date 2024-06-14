// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/services/user_services.dart' as user_services;
import 'package:jatimtour/widgets/universal/buttons/circle_button.dart';
import 'package:jatimtour/widgets/web/buttons/sign_button_web.dart';

class HomePageDrawerWeb extends StatelessWidget {
  const HomePageDrawerWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final userRole =
        user_services.isSignedIn() ? user_services.currentUser!.role : 0;
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
                    backgroundImage: user_services.isSignedIn()
                        ? user_services.currentUser!.getProfilePicture()
                        : const AssetImage("assets/images/placeholder.png")),
                Text(
                  user_services.currentUser != null
                      ? user_services.currentUser!.username
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
              Modular.to.navigate(
                user_services.isSignedIn() ? profileRoute : loginRoute,
              );
            },
          ),
          userRole == 1
              ? ListTile(
                  title: const Text(
                    "Event",
                    style: TextStyle(fontFamily: "Inter"),
                  ),
                  onTap: () => Modular.to.navigate(eventAdminRoute),
                )
              : const SizedBox.shrink(),
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
                  return user_services.isSignedIn()
                      ? CircleButton(
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
                            user_services.signOut();
                            Modular.to.pop();
                          },
                        )
                      : const SignButtonWeb();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
