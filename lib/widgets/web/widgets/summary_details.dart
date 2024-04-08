import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/web/widgets/custom_card_widget.dart';

class SummaryDetails extends StatelessWidget {
  const SummaryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: cardBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildDetails('Pengunjung', '120'),
          buildDetails('Event', '10'),
          buildDetails('Artikel', '14'),
          buildDetails('Followers', '145'),
        ],
      ),
    );
  }

  Widget buildDetails(String key, String value) {
    return Column(
      children: [
        Text(
          key,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
