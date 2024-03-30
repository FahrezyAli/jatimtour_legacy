import 'package:flutter/material.dart';
import 'package:jatimtour/multi/buttons/mp_button.dart';
import 'package:jatimtour/multi/carousel/news_carousel.dart';
import 'package:jatimtour/multi/carousel/recommendation_carousel.dart';
import 'package:jatimtour/multi/pages/article_home_page.dart';
import 'package:jatimtour/multi/pages/calender_home_page.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const NewsCarousel(),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: const Positioned.fill(
            child: Image(
              image: AssetImage('assets/images/border1.png'),
              repeat: ImageRepeat.repeatX,
            ),
          ),
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
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: const Positioned.fill(
            child: Image(
              image: AssetImage('assets/images/border2.png'),
              repeat: ImageRepeat.repeatX,
            ),
          ),
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
          child: CalenderHomePage(),
        ),
        const Center(
          child: MPButton(
            child: Text(
              "Cek Kalender→",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: const Positioned.fill(
              child: Image(
                image: AssetImage('assets/images/border3.png'),
                repeat: ImageRepeat.repeatX,
              ),
            ),
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
        const Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
          child: ArticleHomePage(),
        ),
        const Center(
          child: MPButton(
            child: Text(
              "Baca Lainnya→",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
      ],
    );
  }
}
