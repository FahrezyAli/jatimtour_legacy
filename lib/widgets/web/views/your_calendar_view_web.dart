import 'package:flutter/material.dart';

import '../../../services/article_services.dart';
import '../../../services/user_services.dart';
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
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Your Calendar',
                  style: TextStyle(fontSize: 20.0, fontFamily: "Inter,"),
                ),
              ),
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
