import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../services/article_services.dart';
import '../buttons/circle_button.dart';

class FeaturedArticleCarousel extends StatefulWidget {
  const FeaturedArticleCarousel({super.key});

  @override
  State<FeaturedArticleCarousel> createState() =>
      _FeaturedArticleCarouselState();
}

class _FeaturedArticleCarouselState extends State<FeaturedArticleCarousel> {
  late String _currentId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFeaturedArticle(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final articleData = snapshot.data;
          return Stack(
            children: [
              Positioned(
                child: CarouselSlider.builder(
                  itemCount: articleData!.size,
                  options: CarouselOptions(
                    aspectRatio: 1.98 / 1,
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      _currentId = articleData.docs[index].data().id;
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final article = articleData.docs[index].data();
                    _currentId = article.id;
                    return Image.network(
                      article.coverImageUrl,
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: kIsWeb ? 500.0 : 125.0,
                child: Center(
                  child: CircleButton(
                    color: Colors.white,
                    text: const Text(
                      "Read More→",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: kIsWeb ? 15.0 : 11.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () => Modular.to.pushNamed(
                      '/article?articleId=$_currentId',
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
