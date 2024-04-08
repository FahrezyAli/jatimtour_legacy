import 'package:flutter/material.dart';
import 'package:jatimtour/widgets/web/util/responsive.dart';
import 'package:jatimtour/widgets/web/widgets/bar_graph_widget.dart';
import 'package:jatimtour/widgets/web/widgets/header_widget.dart';
import 'package:jatimtour/widgets/web/widgets/line_chart_card.dart';
import 'package:jatimtour/widgets/web/widgets/summary_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 18),
            const HeaderWidget(),
            // const SizedBox(height: 18),
            // const ActivityDetailsCard(),
            const SizedBox(height: 18),
            const LineChartCard(),
            const SizedBox(height: 18),
            const BarGraphCard(),
            const SizedBox(height: 18),
            if (Responsive.isTablet(context)) const SummaryWidget(),
          ],
        ),
      ),
    );
  }
}
