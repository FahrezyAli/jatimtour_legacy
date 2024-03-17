import 'package:flutter/material.dart';
import 'package:jatimtour/multi/carousel/news_carousel.dart';
import 'package:jatimtour/multi/carousel/recommendation_carousel.dart';

class StartPageWeb extends StatefulWidget {
  const StartPageWeb({super.key});

  @override
  State<StartPageWeb> createState() => _StartPageWebState();
}

class _StartPageWebState extends State<StartPageWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        forceMaterialTransparency: true,
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          const NewsCarousel(),
          SizedBox(
            height: 60.0,
            width: MediaQuery.sizeOf(context).width,
            child: const Positioned.fill(
              child: Image(
                image: AssetImage('assets/images/border1.png'),
                repeat: ImageRepeat.repeatX,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40, left: 60),
            child: Text(
              "Populer di Sekitar\nAnda",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 60,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: RecommendationCarousel(),
          )
        ],
      ),
    );
  }
}
