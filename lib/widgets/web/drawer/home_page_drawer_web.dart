import 'package:builders/builders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/buttons/circle_button.dart';
import 'package:jatimtour/widgets/web/buttons/sign_button_web.dart';

class HomePageDrawerWeb extends StatelessWidget {
  const HomePageDrawerWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: kPinkColor,
            ),
            child: Consumer<UserModel>(
              builder: (context, user) => Column(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: user!.getProfilePicture(),
                  ),
                  user.auth.currentUser != null
                      ? StreamBuilder(
                          stream: user.getDataStream(),
                          builder: (context, snapshot) => Text(
                            snapshot.hasData
                                ? snapshot.data!.data()!['fullName']
                                : "",
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(fontFamily: "Inter"),
            ),
            onTap: () => Modular.to.navigate(homeRoute),
          ),
          ListTile(
            title: const Text(
              "Artikel",
              style: TextStyle(fontFamily: "Inter"),
            ),
            onTap: () => Modular.to.navigate(articleRoute),
          ),
          ListTile(
            title: const Text(
              "Kalender",
              style: TextStyle(fontFamily: "Inter"),
            ),
            onTap: () => Modular.to.navigate(calenderRoute),
          ),
          ListTile(
            title: const Text(
              "Profil",
              style: TextStyle(fontFamily: "Inter"),
            ),
            onTap: () {
              final user = context.read<UserModel>().auth;
              user.currentUser == null
                  ? Modular.to.navigate(loginRoute)
                  : Modular.to.navigate(profileRoute);
            },
          ),
          context.read<UserModel>().auth.currentUser != null
              ? StreamBuilder(
                  stream: context.read<UserModel>().getDataStream(),
                  builder: (context, snapshot) {
                    final adminStatus = snapshot.hasData
                        ? snapshot.data!.data()!['adminStatus']
                        : false;
                    return adminStatus
                        ? ListTile(
                            title: const Text(
                              "Admin",
                              style: TextStyle(fontFamily: "Inter"),
                            ),
                            onTap: () => Modular.to.navigate(adminRoute),
                          )
                        : const SizedBox.shrink();
                  },
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Align(
              alignment: Alignment.center,
              child: Builder(builder: (context) {
                final user = context.read<UserModel>().auth;
                return user.currentUser == null
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
                        onTap: user.signOut,
                      );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
