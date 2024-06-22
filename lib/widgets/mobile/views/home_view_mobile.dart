import 'package:columnbuilder/columnbuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';
import '../../../services/article_services.dart';
import '../../../services/image_services.dart';
import '../../universal/buttons/circle_button.dart';
import '../../universal/carousel/featured_article_carousel.dart';
import '../../universal/carousel/recommendation_carousel.dart';
import '../../universal/views/calendar_home_view.dart';
import '../cards/article_card_mobile.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBackgroundColor,
      child: ListView(
        children: [
          const FeaturedArticleCarousel(),
          Image(
            image: getLocalImage('assets/images/border1.png'),
            repeat: ImageRepeat.repeatX,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Center(
              child: Text(
                "Populer di Sekitar\nAnda",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
            child: RecommendationCarousel(),
          ),
          Image(
            image: getLocalImage('assets/images/border2.png'),
            repeat: ImageRepeat.repeatX,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Center(
              child: RichText(
                text: const TextSpan(
                  text: "Kalender Acara\n",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          "Atur jadwal dan daftarkan diri Anda\ndalam kemeriahan.",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: CalendarHomeView(),
          ),
          Center(
            child: CircleButton(
              color: Colors.white,
              text: const Text(
                "Cek Kalender→",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Modular.to.navigate('$mHomeRoute/1');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Image(
              image: getLocalImage('assets/images/border3.png'),
              repeat: ImageRepeat.repeatX,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Center(
              child: RichText(
                text: const TextSpan(
                  text: "Berbagi Cerita\n",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Dari semua, untuk bersama",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: FutureBuilder(
              future: getSortedArticlesWithLimit(
                field: 'datePublished',
                isDescending: true,
                limit: 3,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final data = snapshot.data!.docs;
                  return ColumnBuilder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ArticleCardMobile(
                        articleId: data[index].id,
                        article: data[index].data(),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Center(
            child: CircleButton(
              color: Colors.white,
              text: const Text(
                "Baca Lainnya→",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Modular.to.navigate('$mHomeRoute/3');
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    );
  }
}
