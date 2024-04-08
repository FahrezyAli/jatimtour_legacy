import 'package:flutter/material.dart';
import 'package:jatimtour/widgets/web/web_scaffold.dart';
import 'articleDummy.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      backgroundColor: Color.fromARGB(255, 232, 224, 224),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/frame.png'),
                  fit: BoxFit.cover,
                ))),
            SizedBox(
              height: 40,
            ),
            Text("Dari Semua, Untuk Anda",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              child: ListTile(
                leading: Image.asset('assets/images/idaho.jpg'),
                title: Text(
                  'Idaho Beach Club, Malang Festival',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                subtitle: Text(
                  'Oleh Fahrezy, 21 Januari',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(thickness: 0.5, indent: 0.3, color: Colors.black),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(20),
              child: ListTile(
                leading: Image.asset('assets/images/article1.jpg'),
                title: Text(
                  'Kemeriahan Malam di Club Pantai Anggar',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                subtitle: Text(
                  'Oleh Fahrezy, 21 Januari',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(thickness: 0.5, indent: 0.3, color: Colors.black),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(20),
              child: ListTile(
                leading: Image.asset('assets/images/article2.jpg'),
                title: Text(
                  'Kemeriahan Malam di Club Pantai Anggar',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ArticleDummy()));
                },
                subtitle: Text(
                  'Oleh Fahrezy, 21 Januari',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(thickness: 0.5, indent: 0.3, color: Colors.black),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(20),
              child: ListTile(
                leading: Image.asset('assets/images/article2.jpg'),
                title: Text(
                  'Kemeriahan Malam di Club Pantai Anggar',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                subtitle: Text(
                  'Oleh Fahrezy, 21 Januari',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(thickness: 0.5, indent: 0.3, color: Colors.black),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(20),
              child: ListTile(
                leading: Image.asset('assets/images/article.png'),
                title: Text(
                  'Kemeriahan Malam di Club Pantai Anggar',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                subtitle: Text(
                  'Oleh Fahrezy, 21 Januari',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(thickness: 0.5, indent: 0.3, color: Colors.black),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(20),
              child: ListTile(
                leading: Image.asset('assets/images/article.png'),
                title: Text(
                  'Kemeriahan Malam di Club Pantai Anggar',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                subtitle: Text(
                  'Oleh Fahrezy, 21 Januari',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
