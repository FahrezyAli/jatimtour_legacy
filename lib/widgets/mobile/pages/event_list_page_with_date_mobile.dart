import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart' as intl;
import 'package:jatimtour/models/event_model.dart';
import 'package:jatimtour/widgets/mobile/cards/event_card_mobile.dart';
import 'package:jatimtour/widgets/mobile/pages/mobile_scaffold.dart';

class EventListPageWithDateMobile extends StatefulWidget {
  final String date;
  const EventListPageWithDateMobile({required this.date, super.key});

  @override
  State<EventListPageWithDateMobile> createState() =>
      _EventListPageWithDateMobileState();
}

class _EventListPageWithDateMobileState
    extends State<EventListPageWithDateMobile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatEn = intl.DateFormat('yyyy-MM-dd');
    final dateFormatId = intl.DateFormat('d MMMM yyyy', 'id_ID');

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
                dateFormatId.format(dateFormatEn.parse(widget.date)),
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
            future: Modular.get<EventModel>().getEventsByDate(
                field: 'startDate', date: dateFormatEn.parse(widget.date)),
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
                      eventData: event.data(),
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
