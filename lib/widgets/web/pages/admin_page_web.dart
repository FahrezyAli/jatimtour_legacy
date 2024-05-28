import 'package:flutter/material.dart';
import 'package:jatimtour/widgets/web/pages/web_scaffold.dart';
import 'package:jatimtour/widgets/web/views/admin_article_view.dart';
import 'package:jatimtour/widgets/web/views/admin_event_view.dart';
import 'package:jatimtour/widgets/web/views/admin_user_view.dart';

class AdminPageWeb extends StatelessWidget {
  const AdminPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: WebScaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.article)),
                Tab(icon: Icon(Icons.calendar_month)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AdminUserView(),
                  AdminArticleView(),
                  AdminEventView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
