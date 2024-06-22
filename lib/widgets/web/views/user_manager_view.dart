import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../models/user_model.dart';
import '../../../services/user_services.dart';

TextStyle _defaultStyle = const TextStyle(fontFamily: 'Inter');

class UserManagerView extends StatefulWidget {
  const UserManagerView({super.key});

  @override
  State<UserManagerView> createState() => _UserManagerViewState();
}

class _UserManagerViewState extends State<UserManagerView> {
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
      'email',
      'username',
      'fullName',
      'phoneNumber',
      'city',
      'role',
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getSortedUsersStream(
        _getFieldFromIndex(_currentSortColumn),
        isDescending: !_isAscending,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return PaginatedDataTable(
            columnSpacing: 35.0,
            header: Text("Users", style: _defaultStyle),
            rowsPerPage: 9,
            sortColumnIndex: _currentSortColumn,
            sortAscending: _isAscending,
            columns: [
              DataColumn(
                  label: Text("Email", style: _defaultStyle), onSort: _sort),
              DataColumn(
                  label: Text("Username", style: _defaultStyle), onSort: _sort),
              DataColumn(
                  label: Text("Nama Lengkap", style: _defaultStyle),
                  onSort: _sort),
              DataColumn(
                  label: Text("Nomor Hape", style: _defaultStyle),
                  onSort: _sort),
              DataColumn(
                  label: Text("Asal Kota", style: _defaultStyle),
                  onSort: _sort),
              DataColumn(label: const Text("Role"), onSort: _sort),
            ],
            source: _DataSource(snapshot.data, context),
          );
        }
      },
    );
  }
}

class _DataSource extends DataTableSource {
  final QuerySnapshot<UserModel>? _data;
  final BuildContext _context;

  _DataSource(this._data, this._context);

  DataCell _sizedDataCell(Widget child) {
    return DataCell(
      SizedBox(
        width: 100,
        child: child,
      ),
    );
  }

  void _updateRole(String uid, int roleValue) {
    showDialog(
      context: _context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text("Edit Role"),
            content: DropdownButtonFormField<int>(
              value: roleValue,
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text("User"),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text("EO"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("Admin"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  roleValue = value!;
                });
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  updateRole(
                    uid,
                    role: roleValue,
                  );
                  Modular.to.pop();
                },
              ),
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  Modular.to.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorSnackBar(String error) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(
          error,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  DataRow? getRow(int index) {
    if (_data != null) {
      final user = _data.docs[index].data();
      return DataRow.byIndex(
        index: index,
        cells: [
          _sizedDataCell(Text(
            user.email,
            style: _defaultStyle,
            overflow: TextOverflow.ellipsis,
          )),
          _sizedDataCell(Text(
            user.username,
            style: _defaultStyle,
            overflow: TextOverflow.ellipsis,
          )),
          _sizedDataCell(Text(
            user.fullName,
            style: _defaultStyle,
            overflow: TextOverflow.ellipsis,
          )),
          _sizedDataCell(Text(
            user.phoneNumber,
            style: _defaultStyle,
            overflow: TextOverflow.ellipsis,
          )),
          _sizedDataCell(Text(
            user.city,
            style: _defaultStyle,
            overflow: TextOverflow.ellipsis,
          )),
          _sizedDataCell(
            Row(
              children: [
                Text(user.role.toString(), style: _defaultStyle),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    if (user.id == currentUser!.id) {
                      _showErrorSnackBar(
                        "You cannot change your own role! Change it directly from Firebase Project or ask another admin",
                      );
                    } else {
                      _updateRole(user.id, user.role);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data?.size ?? 9;

  @override
  int get selectedRowCount => 0;
}
