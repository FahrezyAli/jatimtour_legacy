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
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Consumer<UserModel>(
            builder: (context, user, widget) => Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage:
                        const AssetImage('assets/images/placeholder.png'),
                    foregroundImage: user.auth.currentUser!.photoURL != null
                        ? Image.network(user.auth.currentUser!.photoURL!).image
                        : const AssetImage('assets/images/placeholder.png')
                            as ImageProvider<Object>?,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Ali Ahmad Fahrezy",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
