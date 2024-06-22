import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart' as intl;
import 'package:rowbuilder/rowbuilder.dart';

import '../../../constants.dart';
import '../../../models/event_model.dart';
import '../../../services/event_services.dart';
import 'mobile_scaffold.dart';

class EventPageMobile extends StatelessWidget {
  final String eventId;
  final _quillController = QuillController.basic();

  EventPageMobile({required this.eventId, super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      body: FutureBuilder(
        future: getEvent(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildPage(context, snapshot.data!.data()!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildPage(
    BuildContext context,
    EventModel event,
  ) {
    _quillController.document =
        Document.fromJson(jsonDecode(event.description));
    _quillController.readOnly = true;
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                child: Row(
                  children: [
                    Image.network(
                      event.coverImageUrl,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.eventName,
                              style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            FutureBuilder(
                              future: event.getAuthorUsernameFromAuthorId(),
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data ?? '',
                                  style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 16.0,
                                  ),
                                );
                              },
                            ),
                            Text(
                              intl.DateFormat('d MMMM y')
                                  .format(event.startDate),
                              style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    scrollable: false,
                    showCursor: false,
                    controller: _quillController,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('id'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 15.0, bottom: 10.0, right: 15.0),
                child: RowBuilder(
                  itemCount: event.tags.length,
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
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: kPinkColor,
                  height: 80.0,
                  width: MediaQuery.sizeOf(context).width,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 20.0),
                    child: Text(
                      "© 2024 JATIMTOUR",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
