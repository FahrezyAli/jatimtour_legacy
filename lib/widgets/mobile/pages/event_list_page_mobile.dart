import 'package:flutter/material.dart';
import 'package:jatimtour/services/event_services.dart' as event_services;
import 'package:jatimtour/widgets/mobile/cards/event_card_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/mobile_scaffold.dart';

class EventListPageMobile extends StatefulWidget {
  final String month;
  const EventListPageMobile({required this.month, super.key});

  @override
  State<EventListPageMobile> createState() => _EventListPageMobileState();
}

class _EventListPageMobileState extends State<EventListPageMobile> {
  int? _getMonthNumber() {
    final monthNumber = {
      'Januari': 1,
      'Februari': 2,
      'Maret': 3,
      'April': 4,
      'Mei': 5,
      'Juni': 6,
      'Juli': 7,
      'Agustus': 8,
      'September': 9,
      'Oktober': 10,
      'November': 11,
      'Desember': 12,
    };
    return monthNumber[widget.month];
  }

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      body: ListView(
        children: [
          Image.asset(
            'assets/images/leading.png',
            repeat: ImageRepeat.repeatX,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                widget.month,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 50.0),
            child: Divider(thickness: 1.0, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Text(
                "Seluruh acara di Jawa Timur",
                style: TextStyle(fontFamily: 'inter', fontSize: 15.0),
              ),
            ),
          ),
          FutureBuilder(
            future: event_services.getEventsByMonths(
              field: 'startDate',
              monthNumber: _getMonthNumber()!,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final events = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: events.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return EventCardMobile(
                      eventId: event.id,
                      event: event.data(),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
