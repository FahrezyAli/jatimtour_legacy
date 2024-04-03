import 'package:flutter/material.dart';
import 'package:ibra_jt/article/ArticlePage.dart';

class ArticleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Assuming 2 tabs: Published and Draft
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Published',
                  style: TextStyle(
                    fontFamily: 'Inter-Reg',
                    fontSize: 10,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Draft',
                  style: TextStyle(
                    fontFamily: 'Inter-Reg',
                    fontSize: 10,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ArticlePage(),
            Text('Second Tab'),
          ],
        ),
      ),
    );
  }
}
