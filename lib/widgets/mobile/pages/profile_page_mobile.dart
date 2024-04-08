import 'package:builders/builders.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/models/user_model.dart';

class ProfilePageMobile extends StatefulWidget {
  const ProfilePageMobile({super.key});

  @override
  State<ProfilePageMobile> createState() => _ProfilePageMobileState();
}

class _ProfilePageMobileState extends State<ProfilePageMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/leading.png',
          repeat: ImageRepeat.repeatX,
        ),
        Consumer<UserModel>(
          builder: (context, user) => Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30.0),
                child: CircleAvatar(
                  radius: 75.0,
                  backgroundImage: user!.getProfilePicture(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: StreamBuilder(
                  stream: user.getDataStream(),
                  builder: (context, snapshot) => Text(
                    snapshot.hasData ? snapshot.data!.data()!['fullName'] : "",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
