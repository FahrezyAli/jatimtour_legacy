import 'package:flutter/material.dart';

class ArticleDummy extends StatefulWidget {
  const ArticleDummy({Key? key}) : super(key: key);

  @override
  _ArticleDummyState createState() => _ArticleDummyState();
}

class _ArticleDummyState extends State<ArticleDummy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 224, 224),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/frame.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/article1.jpg'),
                fit: BoxFit.cover,
              )),
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/frame.png'),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  color: const Color.fromARGB(255, 233, 30, 155),
                ),
                Positioned(
                  top: 20,
                  bottom: 20,
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/avatar.png'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('Fahrezy', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/text.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
