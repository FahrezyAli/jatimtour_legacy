import 'package:flutter/material.dart';
import 'package:jatimtour/models/profile.dart';
import 'register.dart';
import 'side_menu_widget.dart';

class ProfileTable extends StatefulWidget {
  final List<Profile> profiles;
  const ProfileTable({Key? key, required this.profiles}) : super(key: key);

  @override
  _ProfileTableState createState() => _ProfileTableState();
}

class _ProfileTableState extends State<ProfileTable> {
  void initState() {
    super.initState();
    widget.profiles.addAll([
      Profile(
        username: 'rainsomethihng',
        fullname: 'Ali Ahmad Fahrezy',
        no_hp: '08222222222',
        kota: 'SURABAYA',
      ),
      Profile(
        username: 'phantaplasm',
        fullname: 'Prithalia Ibra Cardine',
        no_hp: '089650753253',
        kota: 'SURABAYA',
      )
    ]);
  }

  void _addProfile(Profile newProfile) {
    setState(() {
      widget.profiles.add(newProfile);
    });
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenuWidget(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Container(
                height: 25,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/image/frame.png'),
                  fit: BoxFit.cover,
                )),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Navigate to register.dart
                  Profile? newProfile = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );

                  if (newProfile != null) {
                    _addProfile(newProfile);
                  }
                },
                child: Text('Register'), // Button label
              ),
              SizedBox(height: 20),
              DataTable(
                columns: [
                  DataColumn(
                      label: Text(
                    'ID',
                    style: TextStyle(color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    'Username',
                    style: TextStyle(color: Colors.black),
                  )),
                  DataColumn(
                      label: Text('Fullname',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('No. Telepon',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label:
                          Text('Kota', style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('Actions',
                          style: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 1)))),
                ],
                rows: widget.profiles.asMap().entries.map<DataRow>((entry) {
                  final index = entry.key;
                  final profile = entry.value;
                  return DataRow(cells: [
                    DataCell(Text('ADMIN' + (index + 1).toString(),
                        style: TextStyle(color: Colors.black))),
                    DataCell(Text('@' + profile.username,
                        style: TextStyle(color: Colors.black))),
                    DataCell(SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(profile.fullname,
                            style: TextStyle(color: Colors.black)))),
                    DataCell(Text(profile.no_hp,
                        style: TextStyle(color: Colors.black))),
                    DataCell(Text(profile.kota,
                        style: TextStyle(color: Colors.black))),
                    DataCell(
                      Row(
                        children: [
                          InkWell(
                              onTap: () async {
                                // Navigate to Register screen and wait for result
                                Profile? updatedProfile = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Register(profile: profile),
                                  ),
                                );
                                // Update the profile if the result is not null
                                if (updatedProfile != null) {
                                  setState(() {
                                    widget.profiles[index] = updatedProfile;
                                  });
                                }
                              },
                              child: Icon(Icons.edit, color: Colors.black)),
                          InkWell(
                              onTap: (() {
                                setState(() {
                                  widget.profiles.removeAt(index);
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
            ],
          ),
        ),
      ),
    );
  }
}
