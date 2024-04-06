import 'package:flutter/material.dart';

class ArticleHomePageWeb extends StatelessWidget {
  const ArticleHomePageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 300.0,
          width: 350.0,
          margin: const EdgeInsets.only(
            top: 30.0,
            left: 60.0,
            right: 60.0,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/article1.png',
                width: 350.0,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: const TextSpan(
                      text: 'Idaho Beach Club, Malang Festival\n',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Oleh Eric Td, 21 Januari",
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.normal),
                        ),
                      ],
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
