import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RecommendationCarousel extends StatefulWidget {
  const RecommendationCarousel({super.key});

  @override
  State<RecommendationCarousel> createState() => _RecommendationCarouselState();
}

class _RecommendationCarouselState extends State<RecommendationCarousel> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: 3,
          carouselController: _controller,
          itemBuilder: (BuildContext context, int index, int realIndex) =>
              RecommendationCard(
            index: index,
            isCenter: index == realIndex,
          ),
          options: CarouselOptions(
            aspectRatio: 1.9 / 1,
            viewportFraction: 0.5,
            enlargeCenterPage: true,
            enlargeFactor: 0.15,
            height: 400,
          ),
        ),
      ],
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final int index;
  final bool isCenter;
  final List<String> image = ["situbondo", "kuda_lumping", "konser"];

  RecommendationCard({
    this.index = 0,
    this.isCenter = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        child: Stack(
          children: [
            Ink.image(
              image: AssetImage("assets/images/${image[index]}.png"),
            ),
            AnimatedOpacity(
              opacity: 1,
              duration: Durations.short4,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.white],
                        stops: [50],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
