import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';

class SearchViewMobile extends StatefulWidget {
  const SearchViewMobile({super.key});

  @override
  State<SearchViewMobile> createState() => _SearchViewMobileState();
}

class _SearchViewMobileState extends State<SearchViewMobile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBackgroundColor,
      child: ListView(
        children: [
          Image.asset(
            'assets/images/leading.png',
            repeat: ImageRepeat.repeatX,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                'Search',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 50.0),
            child: Divider(thickness: 1.0, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Text(
                "Search for articles and events",
                style: TextStyle(fontFamily: 'inter', fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
