import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/carousel/news_carousel.dart';
import 'package:jatimtour/widgets/carousel/recommendation_carousel.dart';
import 'package:jatimtour/widgets/pages/calender_home_page.dart';
import 'package:jatimtour/widgets/web/buttons/box_button_web.dart';
import 'package:jatimtour/widgets/web/pages/article_home_page_web.dart';
import 'package:jatimtour/widgets/web/web_scaffold.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({super.key});

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      backgroundColor: const Color(0xFFE1E1E1),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Image.asset(
            'assets/images/leading.png',
            height: 10.0,
            repeat: ImageRepeat.repeatX,
          ),
          const NewsCarousel(),
          Image.asset(
            'assets/images/border1.png',
            height: 40.0,
            repeat: ImageRepeat.repeatX,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40, left: 60),
            child: Text(
              "Populer di Sekitar Anda",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 60,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 100.0),
            child: RecommendationCarousel(),
          ),
          Image.asset(
            'assets/images/border2.png',
            height: 40.0,
            repeat: ImageRepeat.repeatX,
          ),
          Container(
            color: kYellowColor,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 60),
                    child: RichText(
                      text: const TextSpan(
                        text: "Kalender Acara\n",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 60,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                "Atur jadwal dan daftarkan diri Anda dalam kemeriahan.",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: CalenderHomePage(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: BoxButton(
                    text: const Text(
                      "Lihat Kalender",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.white,
                    onTap: () => Modular.to.navigate(calenderRoute),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/border3.png',
            height: 40.0,
            repeat: ImageRepeat.repeatX,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 60),
            child: RichText(
              text: const TextSpan(
                text: "Berbagi Cerita\n",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 60,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
                children: [
                  TextSpan(
                    text: "Dari semua, untuk bersama",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
            child: ArticleHomePageWeb(),
          ),
          UnconstrainedBox(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: BoxButton(
                text: const Text(
                  "Artikel Lain",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.white,
                onTap: () => Modular.to.navigate(articleRoute),
              ),
            ),
          ),
          Image.asset(
            'assets/images/border4.png',
            height: 40.0,
            repeat: ImageRepeat.repeatX,
          ),
          Container(
            color: kPinkColor,
            height: 80.0,
            child: const Padding(
              padding: EdgeInsets.only(top: 30.0, left: 20.0),
              child: Text(
                "© 2024 JATIMTOUR",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
