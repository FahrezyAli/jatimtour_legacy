import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:jatimtour/services/user_services.dart' as user_services;

TextStyle _defaultStyle = const TextStyle(fontFamily: 'Inter');

class AdminUserView extends StatefulWidget {
  const AdminUserView({super.key});

  @override
  State<AdminUserView> createState() => _AdminUserViewState();
}

class _AdminUserViewState extends State<AdminUserView> {
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
      stream: user_services.getSortedUsersStream(
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
            source: _DataSource(snapshot.data!, context),
          );
        }
      },
    );
  }
}

class _DataSource extends DataTableSource {
  QuerySnapshot<UserModel> data;
  BuildContext context;

  _DataSource(this.data, this.context);

  void _updateRole(String uid, int roleValue) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text("Edit Role"),
            content: DropdownButton<int>(
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
                  user_services.updateRole(
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

  @override
  DataRow? getRow(int index) {
    final user = data.docs[index].data();
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.email, style: _defaultStyle)),
        DataCell(Text(user.username, style: _defaultStyle)),
        DataCell(Text(user.fullName, style: _defaultStyle)),
        DataCell(Text(user.phoneNumber, style: _defaultStyle)),
        DataCell(Text(user.city, style: _defaultStyle)),
        DataCell(
          Row(
            children: [
              Text(user.role.toString(), style: _defaultStyle),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  int roleValue = user.role;
                  _updateRole(user.id, roleValue);
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
