import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import './LandingPage.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String? _selectedPrefix;
  File? _image;
  bool? _isPressed;

  Future<void> _changeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 251, 226),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'img/registration_header.png',
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Buat Akun',
                  style: TextStyle(
                    fontFamily: 'Inter-Bold',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  'Dan bergabunglah dalam kemeriahan bulanan di kota Anda!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Inter', fontSize: 9),
                ),
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: _changeImage,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        child: _image != null
                            ? ClipOval(
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Image.asset(
                                'img/placeholder.png',
                                height: 100,
                                width: 100,
                              ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: _changeImage,
                          child: Image.asset(
                            'img/edit_profile.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontFamily: 'Inter-Reg',
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '+62',
                              style: TextStyle(
                                fontFamily: 'Inter-Medium',
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 392,
                            height: 40,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.all(10),
                            child: Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'No.Telepon',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter-Reg',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            width: 292,
                            height: 40,
                            child: DropdownButton<String>(
                              hint: Text(
                                _selectedPrefix ?? 'Kota',
                                style: TextStyle(
                                  fontFamily: 'Inter-Reg',
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              value: _selectedPrefix,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedPrefix = value;
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
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontFamily: 'Inter-Reg',
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              underline: Container(),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            width: 200,
                            height: 40,
                            child: Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Kode Pos',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter-Reg',
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isPressed = _isPressed != null ? !_isPressed! : true;
                  });
                },
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 241, 91, 181),
                      width: 2,
                    ),
                    color: _isPressed != null && _isPressed!
                        ? Color.fromARGB(255, 241, 91, 181)
                        : Colors.transparent,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'By signing up, you agree to our Terms & Condition and Policy & Privacy',
                style: TextStyle(
                  fontFamily: 'Inter-Reg',
                  fontSize: 8,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            },
            child: Container(
              width: 150,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(255, 241, 91, 181),
              ),
              child: Text('Buat Akun',
                  style: TextStyle(
                    fontFamily: 'Inter-Bold',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
