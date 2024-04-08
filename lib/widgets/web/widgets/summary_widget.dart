import 'package:flutter/material.dart';
import 'package:jatimtour/widgets/web/widgets/pie_chart_widget.dart';
import 'package:jatimtour/widgets/web/widgets/summary_details.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF171821),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Chart(),
            SizedBox(height: 16),
            SummaryDetails(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
