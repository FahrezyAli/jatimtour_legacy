// ignore_for_file: unnecessary_const

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jatimtour/mobile/pages/main_page_mobile.dart';
import 'package:jatimtour/multi/buttons/mp_button.dart';
import 'package:jatimtour/multi/buttons/picture_select_button.dart';
import 'package:jatimtour/multi/models/user_model.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  File? _profilePicture;
  String? _username;
  String? _fullName;
  String? _phoneNumber;
  String? _city;
  bool _isAcceptTerms = false;

  Future _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final croppedImage = await _cropImage(File(pickedImage.path));
      setState(
        () {
          _profilePicture = croppedImage!;
          Navigator.of(context).pop();
        },
      );
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      cropStyle: CropStyle.circle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: const Color(0xFFF15BB5),
        ),
      ],
    );
    if (croppedImage != null) {
      return File(croppedImage.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE2),
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: Form(
        child: ListView(
          children: [
            SizedBox(
              height: 30.0,
              width: MediaQuery.sizeOf(context).width,
              child: Positioned.fill(
                child: Image.asset(
                  'assets/images/header.png',
                  repeat: ImageRepeat.repeatX,
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  "Buat Akun",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                "Dan bergabunglah dalam kemeriahan bulanan di kota Anda!",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Center(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundImage:
                            const AssetImage('assets/images/placeholder.png'),
                        foregroundImage: _profilePicture != null
                            ? FileImage(_profilePicture!)
                            : const AssetImage('assets/images/placeholder.png')
                                as ImageProvider<Object>?,
                      ),
                    ),
                    Positioned.fill(
                      bottom: 5.0,
                      right: 5.0,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Material(
                          shape: const CircleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () => {
                              showModalBottomSheet(
                                backgroundColor: const Color(0xFFFFFBE2),
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                builder: (context) => DraggableScrollableSheet(
                                  initialChildSize: 0.28,
                                  maxChildSize: 0.4,
                                  minChildSize: 0.28,
                                  expand: false,
                                  builder: (context, scrollController) {
                                    return SingleChildScrollView(
                                      controller: scrollController,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 50.0,
                                          left: 60.0,
                                          right: 60.0,
                                        ),
                                        child: Row(
                                          children: [
                                            PictureSelectButton(
                                              icon: Icons.camera_alt,
                                              text: "Camera",
                                              onTap: () => _pickImage(
                                                  ImageSource.camera),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 90.0),
                                              child: PictureSelectButton(
                                                icon: Icons.image,
                                                text: "Gallery",
                                                onTap: () => _pickImage(
                                                  ImageSource.gallery,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            },
                            child: const Icon(
                              Icons.edit_outlined,
                              size: 35.0,
                              color: Color(0xFFF15BB5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: UnconstrainedBox(
                child: Container(
                  height: 40.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "username",
                        hintStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _username = value,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: UnconstrainedBox(
                child: Container(
                  height: 40.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "nama lengkap",
                        hintStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _fullName = value,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: UnconstrainedBox(
                child: Container(
                  height: 40.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "no. hp",
                        hintStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _phoneNumber = value,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: UnconstrainedBox(
                child: Container(
                  height: 40.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "kota",
                        hintStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _city = value,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: Row(
                children: [
                  Checkbox(
                    side: const BorderSide(
                      color: Color(0xFFF15BB5),
                      width: 2.0,
                    ),
                    fillColor: MaterialStateProperty.resolveWith(
                      ((states) {
                        const Set<MaterialState> interactiveStates =
                            <MaterialState>{
                          MaterialState.pressed,
                          MaterialState.hovered,
                          MaterialState.focused,
                        };
                        if (states.any(interactiveStates.contains) ||
                            _isAcceptTerms) {
                          return const Color(0xFFF15BB5);
                        }
                        return Colors.transparent;
                      }),
                    ),
                    value: _isAcceptTerms,
                    onChanged: (value) => setState(
                      () => _isAcceptTerms = value!,
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: "Saya setuju dengan ",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Syarat",
                          style: TextStyle(
                            color: Color(0xFFF15BB5),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: " dan "),
                        TextSpan(
                          text: "Ketentuan",
                          style: TextStyle(
                            color: Color(0xFFF15BB5),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            UnconstrainedBox(
              child: MPButton(
                text: const Text(
                  "Buat Akun",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                color: const Color(0xFFF15BB5),
                onTap: () async {
                  final user = context.read<UserModel>().auth.currentUser!;
                  final profilePictureRef = FirebaseStorage.instance
                      .ref()
                      .child('users')
                      .child(user.uid)
                      .child('profile_picture.jpg');
                  await profilePictureRef.putFile(_profilePicture!);
                  await user
                      .updatePhotoURL(await profilePictureRef.getDownloadURL());
                  setState(() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainPageMobile(),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
