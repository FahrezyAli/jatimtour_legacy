import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';

class RecommendationCarousel extends StatelessWidget {
  const RecommendationCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: 3,
          carouselController: CarouselController(),
          itemBuilder: (BuildContext context, int index, int realIndex) =>
              RecommendationCard(
            index: index,
            isCenter: index == realIndex,
          ),
          options: CarouselOptions(
            viewportFraction: 0.5,
            enlargeCenterPage: true,
            enlargeFactor: 0.15,
            height: kIsWeb ? 350.0 : 100.0,
          ),
        ),
      ],
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final int index;
  final bool isCenter;
  final image = ["situbondo", "kuda_lumping", "konser"];
  final city = ["Situbondo", "Banyuwangi", "Surabaya"];

  RecommendationCard({
    this.index = 0,
    this.isCenter = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            InkWell(
              child: Ink.image(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/${image[index]}.png"),
              ),
              onTap: () {
                Modular.to.pushNamed("$eventListRoute?location=${city[index]}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
