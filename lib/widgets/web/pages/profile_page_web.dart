import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';
import '../../../route_guard/role_guard.dart';
import '../../../services/user_services.dart';
import '../views/article_manager_view.dart';
import '../views/event_manager_view.dart';
import '../views/profile_view_web.dart';
import '../views/user_manager_view.dart';
import '../views/your_article_drafts_view_web.dart';
import '../views/your_articles_view_web.dart';
import '../views/your_calendar_view_web.dart';
import 'web_scaffold.dart';

class ProfilePageWebModule extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const ProfilePageWeb(),
      transition: TransitionType.fadeIn,
      children: [
        ChildRoute(
          '/you',
          child: (context) => const ProfileViewWeb(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute(
          yourArticlesRoute,
          child: (context) => const YourArticlesViewWeb(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute(
          yourArticleDraftsRoute,
          child: (context) => const YourArticleDraftsViewWeb(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute(
          yourCalendarRoute,
          child: (context) => const YourCalendarViewWeb(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute(
          userManagerRoute,
          child: (context) => const UserManagerView(),
          transition: TransitionType.fadeIn,
          guards: [RoleGuard(role: 2)],
        ),
        ChildRoute(
          articleManagerRoute,
          child: (context) => const ArticleManagerView(),
          transition: TransitionType.fadeIn,
          guards: [RoleGuard(role: 2)],
        ),
        ChildRoute(
          eventManagerRoute,
          child: (context) => EventManagerView(
            user: currentUser!,
          ),
          transition: TransitionType.fadeIn,
          guards: [RoleGuard(role: 1)],
        ),
      ],
    );
  }
}

class ProfilePageWeb extends StatefulWidget {
  const ProfilePageWeb({super.key});

  @override
  State<ProfilePageWeb> createState() => _ProfilePageWebState();
}

class _ProfilePageWebState extends State<ProfilePageWeb> {
  int selectedTile = 0;

  Color _getTileColor(int index) {
    return selectedTile == index ? kPurpleColor : kPinkColor;
  }

  String _getRole() {
    switch (currentUser!.role) {
      case 0:
        return "User";
      case 1:
        return "Event Organizer";
      case 2:
        return "Admin";
      default:
        return "User";
    }
  }

  Widget _profileTile() {
    return Material(
      color: _getTileColor(0),
      child: InkWell(
        onTap: () {
          Modular.to.navigate('$profileRoute/you');
          setState(() {
            selectedTile = 0;
          });
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                top: 10.0,
                bottom: 10.0,
              ),
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: currentUser!.getProfilePicture(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: currentUser!.role != 0
                  ? RichText(
                      text: TextSpan(
                        text: "${currentUser!.username}\n",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: "Inter",
                        ),
                        children: [
                          TextSpan(
                            text: _getRole(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontFamily: "Inter",
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(
                      currentUser!.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: "Inter",
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      body: Row(
        children: [
          Material(
            color: kPinkColor,
            child: SizedBox(
              width: 225.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    _profileTile(),
                    ListTile(
                      leading: const Icon(
                        Icons.article,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Your Articles",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: "Inter",
                        ),
                      ),
                      tileColor: _getTileColor(1),
                      onTap: () {
                        Modular.to.navigate('$profileRoute$yourArticlesRoute');
                        setState(() {
                          selectedTile = 1;
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.article_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Your Article Drafts",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: "Inter",
                        ),
                      ),
                      tileColor: _getTileColor(2),
                      onTap: () {
                        Modular.to.navigate(
                          '$profileRoute$yourArticleDraftsRoute',
                        );
                        setState(() {
                          selectedTile = 2;
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Your Calendar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: "Inter",
                        ),
                      ),
                      tileColor: _getTileColor(3),
                      onTap: () {
                        Modular.to.navigate('$profileRoute$yourCalendarRoute');
                        setState(() {
                          selectedTile = 3;
                        });
                      },
                    ),
                    currentUser!.role == 2
                        ? ListTile(
                            leading: const Icon(
                              Icons.manage_accounts,
                              color: Colors.white,
                            ),
                            title: const Text(
                              "User Manager",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "Inter",
                              ),
                            ),
                            tileColor: _getTileColor(4),
                            onTap: () {
                              Modular.to.navigate(
                                '$profileRoute$userManagerRoute',
                              );
                              setState(() {
                                selectedTile = 4;
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                    currentUser!.role == 2
                        ? ListTile(
                            leading: const Icon(
                              Icons.description,
                              color: Colors.white,
                            ),
                            title: const Text(
                              "Article Manager",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "Inter",
                              ),
                            ),
                            tileColor: _getTileColor(5),
                            onTap: () {
                              Modular.to.navigate(
                                '$profileRoute$articleManagerRoute',
                              );
                              setState(() {
                                selectedTile = 5;
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                    currentUser!.role >= 1
                        ? ListTile(
                            leading: const Icon(
                              Icons.event,
                              color: Colors.white,
                            ),
                            title: const Text(
                              "Event Manager",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "Inter",
                              ),
                            ),
                            tileColor: _getTileColor(6),
                            onTap: () {
                              Modular.to.navigate(
                                '$profileRoute$eventManagerRoute',
                              );
                              setState(() {
                                selectedTile = 6;
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Sign Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: "Inter",
                        ),
                      ),
                      tileColor: kPinkColor,
                      onTap: () async {
                        await signOut();
                        Modular.to.navigate(rootRoute);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: RouterOutlet(),
          ),
        ],
      ),
    );
  }
}
