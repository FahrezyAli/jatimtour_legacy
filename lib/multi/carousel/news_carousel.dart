import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewsCarousel extends StatefulWidget {
  const NewsCarousel({super.key});

  @override
  State<NewsCarousel> createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: const [
            Image(
              image: AssetImage('assets/images/banyuwangi.png'),
            ),
            Image(
              image: AssetImage('assets/images/music_fest.png'),
            ),
            Image(
              image: AssetImage('assets/images/kawah_ijen.png'),
            ),
            Image(
              image: AssetImage('assets/images/sunrise.png'),
            ),
          ],
          options: CarouselOptions(
            aspectRatio: 1.98 / 1,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) => setState(
              () {
                _index = index;
              },
            ),
          ),
        ),
      ],
    );
  }
}
