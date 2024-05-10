import 'package:flutter/material.dart';

class ArticleHomeViewMobile extends StatelessWidget {
  const ArticleHomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.0,
          margin: const EdgeInsets.only(
            top: 10.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Row(
            children: [
              Image.asset('assets/images/article1.png'),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 5.0),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: const TextSpan(
                      text: 'Panduan Klub Pantai di Malang',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
