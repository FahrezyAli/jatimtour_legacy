import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart' as intl;
import 'package:rowbuilder/rowbuilder.dart';

import '../../../constants.dart';
import '../../../models/event_model.dart';

class EventCardMobile extends StatelessWidget {
  final String eventId;
  final EventModel event;

  const EventCardMobile({
    required this.eventId,
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Material(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          onTap: () {
            Modular.to.pushNamed('$eventRoute?eventId=$eventId');
          },
          child: Ink(
            height: 130.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Ink(
                  height: 130.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: NetworkImage(event.coverImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Ink(
                    padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: FutureBuilder(
                            future: event.getAuthorUsernameFromAuthorId(),
                            builder: (context, snapshot) {
                              return RichText(
                                text: TextSpan(
                                  text: event.eventName,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '\n${snapshot.data ?? ''}, ${intl.DateFormat('d MMMM y').format(event.startDate)}',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\n${event.city}',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: RowBuilder(
                            itemCount:
                                event.tags.length > 2 ? 2 : event.tags.length,
                            reversed: false,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 5.0),
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: kPinkColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  '#${event.tags[index]}',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
