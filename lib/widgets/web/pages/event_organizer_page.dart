import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart' as intl;
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/event_model.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/widgets/web/pages/web_scaffold.dart';

TextStyle _defaultStyle = const TextStyle(fontFamily: 'Inter');

class EventOrganizerView extends StatefulWidget {
  const EventOrganizerView({super.key});

  @override
  State<EventOrganizerView> createState() => _EventOrganizerViewState();
}

class _EventOrganizerViewState extends State<EventOrganizerView> {
  int _currentSortColumn = 0;
  bool _isAscending = true;

  void _sort(int columnIndex, bool isAscending) {
    setState(
      () {
        _currentSortColumn = columnIndex;
        _isAscending = isAscending;
      },
    );
  }

  String _getFieldFromIndex(int index) {
    return <String>[
      'eventName',
      'eventOrganizer',
      'city',
      'tags',
      'startDate',
      'dateCreated',
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      body: StreamBuilder(
        stream:
            Modular.get<EventModel>().getSortedEventsStreamWithEventOrganizer(
          _getFieldFromIndex(_currentSortColumn),
          eventOrganizer: Modular.get<UserModel>().userData!['username'],
          isDescending: !_isAscending,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final events = snapshot.data!;
          return PaginatedDataTable(
            header: Text("Events", style: _defaultStyle),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Modular.to.pushNamed(createEventRoute);
                },
              ),
            ],
            rowsPerPage: 9,
            sortColumnIndex: _currentSortColumn,
            sortAscending: _isAscending,
            columns: [
              DataColumn(
                  label: Text("Nama Event", style: _defaultStyle),
                  onSort: _sort),
              DataColumn(
                  label: Text("Event Organizer", style: _defaultStyle),
                  onSort: _sort),
              DataColumn(
                  label: Text("Kota", style: _defaultStyle), onSort: _sort),
              DataColumn(
                  label: Text("Tags", style: _defaultStyle), onSort: _sort),
              DataColumn(
                  label: Text("Tanggal Mulai Event", style: _defaultStyle),
                  onSort: _sort),
              DataColumn(
                  label: Text("Tanggal Kreasi", style: _defaultStyle),
                  onSort: _sort),
              DataColumn(label: Text("Action", style: _defaultStyle)),
            ],
            source: _DataSource(events, context),
          );
        },
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  QuerySnapshot<Map<String, dynamic>> data;
  BuildContext context;

  _DataSource(this.data, this.context);

  @override
  DataRow? getRow(int index) {
    final event = data.docs[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(event['eventName'], style: _defaultStyle)),
        DataCell(Text(event['eventOrganizer'], style: _defaultStyle)),
        DataCell(Text(event['city'], style: _defaultStyle)),
        DataCell(Text(event['tags'].join(', '), style: _defaultStyle)),
        DataCell(Text(
          intl.DateFormat.yMd().format(
            event['startDate'].toDate(),
          ),
          style: _defaultStyle,
        )),
        DataCell(Text(
          intl.DateFormat.yMd().format(
            event['dateCreated'].toDate(),
          ),
          style: _defaultStyle,
        )),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Modular.to.navigate('/admin/event/edit', arguments: event);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Modular.get<EventModel>().deleteEventsFromId(event.id);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.size;

  @override
  int get selectedRowCount => 0;
}