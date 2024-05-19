import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/buttons/circle_button.dart';

class YourArticleViewMobile extends StatelessWidget {
  const YourArticleViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Published",
                  style: TextStyle(fontFamily: "Inter", fontSize: 15.0),
                ),
              ),
              Tab(
                child: Text(
                  "Drafts",
                  style: TextStyle(fontFamily: "Inter", fontSize: 15.0),
                ),
              ),
            ],
          ),
          Expanded(child: TabBarView(children: [Container(), Container()])),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircleButton(
                text: const Text(
                  "Buat Artikel",
                  style: TextStyle(fontFamily: "Inter", color: Colors.white),
                ),
                color: kPurpleColor,
                onTap: () {
                  Modular.to.pushNamed(createArticleRoute);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
