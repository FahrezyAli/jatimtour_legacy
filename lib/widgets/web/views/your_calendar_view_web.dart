import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../services/article_services.dart';
import '../../../services/user_services.dart';
import '../../universal/buttons/circle_button.dart';
import '../cards/list_article_card_web.dart';

class YourCalendarViewWeb extends StatelessWidget {
  const YourCalendarViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          elevation: 5.0,
          child: Ink(
            width: double.infinity,
            height: 50,
            child: Row(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Your Calendar',
                      style: TextStyle(fontSize: 20.0, fontFamily: "Inter,"),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: CircleButton(
                        text: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 15.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        color: kPinkColor,
                        height: 30.0,
                        width: 75.0,
                        radius: 5.0,
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: StreamBuilder(
              stream: getDraftsArticleStreamFromAuthorId(
                currentUser!.id,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final data = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListArticleCardWeb(
                        articleId: data[index].id,
                        article: data[index].data(),
                        withUpdateAndDelete: true,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
