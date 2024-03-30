import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jatimtour/mobile/pages/main_page_mobile.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 226),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  'Buat Akun',
                  style: TextStyle(
                    fontFamily: 'Inter-Bold',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                const Text(
                  'Dan bergabunglah dalam kemeriahan bulanan di kota Anda!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Inter', fontSize: 9),
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: _changeImage,
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
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
                              : Container()),
                    ),
                    Positioned(
                      top: 60,
                      right: 0,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: _changeImage,
                            child: Container()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 500,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontFamily: 'Inter-Reg',
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              '+62',
                              style: TextStyle(
                                fontFamily: 'Inter-Medium',
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 392,
                            height: 40,
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.all(10),
                            child: Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
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
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            width: 292,
                            height: 40,
                            child: DropdownButton<String>(
                              hint: Text(
                                _selectedPrefix ?? 'Kota',
                                style: const TextStyle(
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
                                      style: const TextStyle(
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
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            width: 200,
                            height: 40,
                            child: Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
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
          const SizedBox(
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
                      color: const Color.fromARGB(255, 241, 91, 181),
                      width: 2,
                    ),
                    color: _isPressed != null && _isPressed!
                        ? const Color.fromARGB(255, 241, 91, 181)
                        : Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'By signing up, you agree to our Terms & Condition and Policy & Privacy',
                style: TextStyle(
                  fontFamily: 'Inter-Reg',
                  fontSize: 8,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainPageMobile()),
              );
            },
            child: Container(
              width: 150,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 241, 91, 181),
              ),
              child: const Text(
                'Buat Akun',
                style: TextStyle(
                  fontFamily: 'Inter-Bold',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
