import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart' as intl;

import '../../../constants.dart';
import '../../../models/event_model.dart';
import '../../../models/user_model.dart';
import '../../../services/event_services.dart';

TextStyle _defaultStyle = const TextStyle(fontFamily: 'Inter');

class EventManagerView extends StatefulWidget {
  final UserModel user;

  const EventManagerView({required this.user, super.key});

  @override
  State<EventManagerView> createState() => _EventManagerViewState();
}

class _EventManagerViewState extends State<EventManagerView> {
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
      'eventOrganizerId',
      'city',
      'tags',
      'startDate',
      'dateCreated',
    ][index];
  }

  Stream<QuerySnapshot<EventModel>> getStreamBasedOnRole() {
    if (widget.user.role == 1) {
      return getSortedEventsStreamWithEventOrganizerId(
        _getFieldFromIndex(_currentSortColumn),
        eventOrganizerId: widget.user.id,
        isDescending: !_isAscending,
      );
    } else {
      return getSortedEventsStream(
        _getFieldFromIndex(_currentSortColumn),
        isDescending: !_isAscending,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getStreamBasedOnRole(),
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
                label: Text("Nama Event", style: _defaultStyle), onSort: _sort),
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
          source: _DataSource(events),
        );
      },
    );
  }
}

class _DataSource extends DataTableSource {
  final QuerySnapshot<EventModel> _data;

  _DataSource(this._data);

  DataCell _sizedDataCell(Widget child) {
    return DataCell(
      SizedBox(
        width: 100,
        child: child,
      ),
    );
  }

  @override
  DataRow? getRow(int index) {
    final event = _data.docs[index].data();
    return DataRow.byIndex(
      index: index,
      cells: [
        _sizedDataCell(Text(
          event.eventName,
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(Text(
          event.eventOrganizerId,
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(Text(
          event.city,
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(Text(
          event.tags.join(', '),
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(Text(
          intl.DateFormat.yMd().format(
            event.startDate,
          ),
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(Text(
          intl.DateFormat.yMd().format(
            event.dateCreated,
          ),
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Modular.to.pushNamed(
                    '$updateEventRoute?eventId=${event.id}',
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteEvent(event.id);
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
  int get rowCount => _data.size;

  @override
  int get selectedRowCount => 0;
}
