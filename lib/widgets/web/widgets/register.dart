import 'package:flutter/material.dart';
import 'package:jatimtour/models/profile.dart';

class Register extends StatefulWidget {
  final Profile? profile;
  const Register({Key? key, this.profile}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController no_hpController = TextEditingController();
  TextEditingController kotaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.profile != null) {
      usernameController.text = widget.profile!.username;
      fullnameController.text = widget.profile!.fullname;
      no_hpController.text = widget.profile!.no_hp;
      kotaController.text = widget.profile!.kota;
    }
  }

  String? _selectedCity;
  List<Profile> profiles = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: usernameController,
              maxLength: 20,
              decoration: const InputDecoration(
                hintText: '@Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: fullnameController,
              maxLength: 50,
              decoration: const InputDecoration(
                hintText: 'Fullname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: no_hpController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'No. Telepon',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              hint: Text(_selectedCity ?? 'Kota'),
              value: _selectedCity,
              onChanged: (String? value) {
                setState(() {
                  _selectedCity = value;
                });
              },
              items: <String>[
                'BANGKALAN',
                'BANYUWANGI',
                'BATU',
                'BLITAR',
                'BOJONEGORO',
                'BONDOWOSO',
                'GRESIK',
                'JEMBER',
                'JOMBANG',
                'KEDIRI',
                'PAMENANG',
                'LAMONGAN',
                'LUMAJANG',
                'MADIUN',
                'MAGETAN',
                'MALANG',
                'MOJOKERTO',
                'NGANJUK',
                'NGAWI',
                'PACITAN',
                'PAMEKASAN',
                'PASURUAN',
                'PONOROGO',
                'PROBOLINGGO',
                'SAMPANG',
                'SIDOARJO',
                'SITUBONDO',
                'SUMENEP',
                'TRENGGALEK',
                'TUBAN',
                'TULUNGAGUNG',
                'SURABAYA'
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              underline: Container(),
            ),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text.trim();
                String fullname = fullnameController.text.trim();
                String no_hp = no_hpController.text.trim();
                String kota = _selectedCity ?? '';
                if (username.isNotEmpty &&
                    fullname.isNotEmpty &&
                    no_hp.isNotEmpty &&
                    kota.isNotEmpty) {
                  if (widget.profile != null) {
                    // Editing existing profile
                    Profile updatedProfile = Profile(
                      username: username,
                      fullname: fullname,
                      no_hp: no_hp,
                      kota: kota,
                    );
                    // Navigate back to ProfileTable screen and pass the updatedProfile as result
                    Navigator.pop(context, updatedProfile);
                  } else {
                    setState(() {
                      usernameController.text = '';
                      fullnameController.text = '';
                      no_hpController.text = '';
                      kotaController.text = '';
                      profiles.add(Profile(
                        username: username,
                        fullname: fullname,
                        no_hp: no_hp,
                        kota: kota,
                      ));
                    });
                    Navigator.pop(context, profiles.last);
                  }
                }
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
