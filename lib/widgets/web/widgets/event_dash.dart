import 'package:flutter/material.dart';
import 'package:jatimtour/models/event.dart';
import 'eventRegister.dart';
import 'package:intl/intl.dart';

class EventTable extends StatefulWidget {
  final List<Event> events;

  const EventTable({Key? key, required this.events}) : super(key: key);

  @override
  _EventTableState createState() => _EventTableState();
}

class _EventTableState extends State<EventTable> {
  void initState() {
    super.initState();
    widget.events.addAll([
      Event(
          name: 'Festival Demokrasi Hari Pahlawan, Surabaya',
          description:
              'Festivel Demokrasi Hari pAhlawan adalah sebuahhestival yang dibuat untuk memperingati Hari Pahlawan. Acara ini meliputi: teater rakyat, music festival, thrifting, dan tour museum rakyat',
          city: 'SURABAY',
          address: 'Tugu Pahlawan, Surabaya',
          date: DateTime(2024, 11, 10),
          type: 'Offline',
          quota: '120',
          price: '15.000',
          endPrice: '15.000'),
      Event(
          name: 'Airlangga Education Expo',
          description:
              'Airlangga Education Expo is an educational event organized by Airlangga University. It serves as a platform for students, parents, and educators to explore various educational opportunities offered by the university. The expo typically includes presentations, exhibitions, workshops, and interactive sessions designed to showcase the universitys academic programs, research initiatives, student life, and support services. Attendees have the opportunity to interact with faculty members, current students, and alumni to gain insights into the universitys culture, facilities, and academic offerings. The expo aims to inform, inspire, and empower individuals to make informed decisions about their educational and career paths.',
          city: 'SURABAYA',
          address: 'Airlangga Convention Center, Kampus C',
          date: DateTime(2024, 7, 7),
          type: 'Offline',
          quota: '600',
          price: '0',
          endPrice: '0'),
    ]);
  }

  void _addEvent(Event newEvent) {
    setState(() {
      widget.events.add(newEvent);
    });
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Navigate to register.dart
                  Event? newEvent = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventRegister(event: null)),
                  );

                  if (newEvent != null) {
                    _addEvent(newEvent);
                  }
                },
                child: Text('Register Event'), // Button label
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 15,
                  dataRowMaxHeight: 50,
                  columns: [
                    DataColumn(
                        label: Text(
                      'ID',
                      style: TextStyle(color: Colors.black),
                    )),
                    DataColumn(
                        label: Text(
                      'Name',
                      style: TextStyle(color: Colors.black),
                    )),
                    DataColumn(
                        label: Text('Description',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('City',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('Address',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('Type',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('Date',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('Quota',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('Price',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('End Price',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('Actions',
                            style: TextStyle(color: Colors.black))),
                  ],
                  rows: widget.events.asMap().entries.map<DataRow>((entry) {
                    final index = entry.key;
                    final event = entry.value;
                    return DataRow(cells: [
                      DataCell(Text((index + 1).toString(),
                          style: TextStyle(color: Colors.black))),
                      DataCell(SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                              width: 150,
                              child: Text(event.name,
                                  style: TextStyle(color: Colors.black))))),
                      DataCell(SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                              width: 300,
                              child: Text(event.description,
                                  style: TextStyle(color: Colors.black))))),
                      DataCell(Text(event.city,
                          style: TextStyle(color: Colors.black))),
                      DataCell(SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                            width: 180,
                            child: Text(event.address,
                                style: TextStyle(color: Colors.black))),
                      )),
                      DataCell(Text(event.type,
                          style: TextStyle(color: Colors.black))),
                      DataCell(
                        Text(
                          DateFormat('yyyy-MM-dd').format(event.date),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      DataCell(Text(event.quota,
                          style: TextStyle(color: Colors.black))),
                      DataCell(Text(event.price,
                          style: TextStyle(color: Colors.black))),
                      DataCell(Text(event.endPrice,
                          style: TextStyle(color: Colors.black))),
                      DataCell(
                        Row(
                          children: [
                            InkWell(
                                onTap: () async {
                                  // Navigate to Register screen and wait for result
                                  Event? updatedEvent = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EventRegister(event: event),
                                    ),
                                  );
                                  // Update the profile if the result is not null
                                  if (updatedEvent != null) {
                                    setState(() {
                                      widget.events[index] = updatedEvent;
                                    });
                                  }
                                },
                                child: Icon(Icons.edit, color: Colors.black)),
                            InkWell(
                                onTap: (() {
                                  setState(() {
                                    widget.events.removeAt(index);
                                  });
                                  //
                                }),
                                child: Icon(Icons.delete, color: Colors.black)),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
