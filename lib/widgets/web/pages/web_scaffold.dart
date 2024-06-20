import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';
import '../../../services/user_services.dart' as user_services;
import '../buttons/action_button_web.dart';

class WebScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget>? actions;
  final ImageProvider? image;
  final double horizontalPadding;
  final Widget? body;

  const WebScaffold({
    this.backgroundColor,
    this.actions,
    this.image,
    this.horizontalPadding = 300.0,
    this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        actions: actions,
        backgroundColor: kPinkColor,
        toolbarHeight: 70,
        flexibleSpace: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                right: 10.0,
                bottom: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: ActionButtonWeb(
                      text: "Search",
                      route: searchRoute,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: ActionButtonWeb(
                      text: "Calendar",
                      route: calendarRoute,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: ActionButtonWeb(
                      text: "Home",
                      route: rootRoute,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundImage: user_services.isSignedIn()
                                ? user_services.currentUser!.getProfilePicture()
                                : const AssetImage(
                                    "assets/images/placeholder.png",
                                  ),
                          ),
                          onTap: () => Modular.to.navigate('$profileRoute/you'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/leading.png',
              height: 10.0,
              width: MediaQuery.sizeOf(context).width,
              repeat: ImageRepeat.repeatX,
            ),
          ],
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "JATIMTOUR",
            style: TextStyle(
              fontFamily: "KronaOne",
              fontSize: 30.0,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          if (image != null)
            Positioned.fill(
              child: Image(
                image: image!,
                fit: BoxFit.cover,
              ),
            ),
          if (image != null)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Material(
                color: backgroundColor,
                child: body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
