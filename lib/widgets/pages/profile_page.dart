import 'package:flutter/material.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/leading.png',
          repeat: ImageRepeat.repeatX,
        ),
        Consumer<UserModel>(
          builder: (context, user, widget) => Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30.0),
                child: CircleAvatar(
                  radius: 75.0,
                  backgroundImage: user.getProfilePicture(),
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
