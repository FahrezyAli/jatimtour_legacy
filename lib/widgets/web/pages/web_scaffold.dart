import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';
import '../../../services/image_services.dart';
import '../../../services/user_services.dart';
import '../buttons/action_button_web.dart';

class WebScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Widget? body;
  final bool showFlexible;

  const WebScaffold({
    this.backgroundColor,
    this.actions,
    this.body,
    this.showFlexible = true,
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
        flexibleSpace: showFlexible
            ? Column(
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
                                  backgroundImage: isSignedIn()
                                      ? currentUser!.getProfilePicture()
                                      : getLocalImage(
                                          "assets/images/placeholder.png",
                                        ),
                                ),
                                onTap: () => Modular.to.navigate(
                                  '$profileRoute/you',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image(
                    image: getLocalImage('assets/images/leading.png'),
                    height: 10.0,
                    width: MediaQuery.sizeOf(context).width,
                    repeat: ImageRepeat.repeatX,
                  ),
                ],
              )
            : null,
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
      body: body,
    );
  }
}
