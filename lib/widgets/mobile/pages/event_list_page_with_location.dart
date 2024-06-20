import 'package:flutter/material.dart';

import '../../../services/event_services.dart' as event_services;
import '../cards/event_card_mobile.dart';
import 'mobile_scaffold.dart';

class EventListPageWithLocationMobile extends StatelessWidget {
  final String location;
  const EventListPageWithLocationMobile({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                location,
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
            future: event_services.getEventsByLocation(location: location),
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
