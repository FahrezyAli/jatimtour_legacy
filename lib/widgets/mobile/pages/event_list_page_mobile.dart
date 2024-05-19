import 'package:flutter/material.dart';
import 'package:jatimtour/widgets/mobile/pages/mobile_scaffold.dart';

class EventListPageMobile extends StatefulWidget {
  final String month;

  const EventListPageMobile({required this.month, super.key});

  @override
  State<EventListPageMobile> createState() => _EventListPageMobileState();
}

class _EventListPageMobileState extends State<EventListPageMobile> {
  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      body: ListView(
        children: [
          Image.asset(
            'assets/images/leading.png',
            repeat: ImageRepeat.repeatX,
          ),
          Text(widget.month),
        ],
      ),
    );
  }
}
