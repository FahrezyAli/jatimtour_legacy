import 'package:flutter/material.dart';
import 'package:jatimtour/widgets/buttons/mp_button.dart';
import 'package:jatimtour/widgets/carousel/news_carousel.dart';
import 'package:jatimtour/widgets/carousel/recommendation_carousel.dart';
import 'package:jatimtour/widgets/pages/article_home_page.dart';
import 'package:jatimtour/widgets/pages/calender_home_page.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
<<<<<<< HEAD:lib/mobile/pages/home_page_mobile.dart
        Image.asset('assets/images/leading.png', repeat: ImageRepeat.repeatX,),
=======
        Image.asset(
          'assets/images/leading.png',
          repeat: ImageRepeat.repeatX,
        ),
>>>>>>> 70a2ab6 (some articles prototype):lib/widgets/mobile/pages/home_page_mobile.dart
        const NewsCarousel(),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Positioned.fill(
            child: Image.asset(
              'assets/images/border1.png',
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
          child: Positioned.fill(
            child: Image.asset(
              'assets/images/border2.png',
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
        Center(
          child: MPButton(
            color: Colors.white,
            text: const Text(
              "Cek Kalender→",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Positioned.fill(
              child: Image.asset(
                'assets/images/border3.png',
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
        Center(
          child: MPButton(
            color: Colors.white,
            text: const Text(
              "Baca Lainnya→",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
      ],
    );
  }
}