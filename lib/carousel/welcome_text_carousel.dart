import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class WelcomeTextCarousel extends StatefulWidget {
  const WelcomeTextCarousel({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeTextCarousel();
}

class _WelcomeTextCarousel extends State<WelcomeTextCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: const [
            Text(
              "Atur jadwalmu untuk kemeriahan yang berlanjut",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Text(
              "Bagikan kisahmu kepada semua",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Text(
              "Eksplor acara-acara di Jawa Timur",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
          options: CarouselOptions(
            height: 60.0,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) => setState(
              () {
                _currentIndex = index;
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 2.0),
          child: DotsIndicator(
            dotsCount: 3,
            position: _currentIndex,
            decorator: const DotsDecorator(
              color: Color(0x80D9D9D9),
              activeColor: Color(0xFFD9D9D9),
            ),
          ),
        ),
      ],
    );
  }
}
