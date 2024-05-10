import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/web/pages/web_scaffold.dart';

class ProfilePageWeb extends StatelessWidget {
  const ProfilePageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserModel>();
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
                Column(
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
                          snapshot.hasData
                              ? snapshot.data!.data()!['fullName']
                              : "",
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: StreamBuilder(
                        stream: user.getDataStream(),
                        builder: (context, snapshot) => Text(
                          snapshot.hasData
                              ? snapshot.data!.data()!['phoneNumber']
                              : "",
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: StreamBuilder(
                        stream: user.getDataStream(),
                        builder: (context, snapshot) => Text(
                          snapshot.hasData
                              ? snapshot.data!.data()!['city']
                              : "",
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    Image.asset(
                      'assets/images/article1.png',
                      width: 350.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      alignment: Alignment.topLeft,
                      child: Center(
                        child: RichText(
                          text: const TextSpan(
                            text: 'Idaho Beach Club, Malang Festival\n',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: "Oleh Fahrezy, 21 Januari",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                    Image.asset(
                      'assets/images/article2.png',
                      width: 350.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      alignment: Alignment.topLeft,
                      child: Center(
                        child: RichText(
                          text: const TextSpan(
                            text: 'Liburan Klasik di Banyuwangi 2024\n',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: "Oleh Fahrezy, 5 Februari",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
