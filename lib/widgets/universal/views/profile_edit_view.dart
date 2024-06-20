import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';
import '../../../services/user_services.dart' as user_services;
import '../buttons/picture_select_button.dart';
import '../buttons/circle_button.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  CroppedFile? _profilePicture;
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? _selectedCity;

  final _user = user_services.currentUser!;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final croppedImage = await _cropImage(File(pickedImage.path));
      setState(
        () {
          if (croppedImage != null) {
            _profilePicture = croppedImage;
          }
          kIsWeb ? null : Modular.to.pop();
        },
      );
    }
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: kPinkColor,
            cropStyle: CropStyle.circle),
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
          size: const CropperSize(width: 350, height: 350),
        )
      ],
    );
    if (croppedImage != null) {
      return croppedImage;
    }
    return null;
  }

  Future<void> _update() async {
    final usedUsername = await user_services.getUsedUsername();
    usedUsername.remove(user_services.currentUser!.username);
    if (_usernameController.text == "" ||
        _fullNameController.text == "" ||
        _phoneNumberController.text == "" ||
        _selectedCity == "") {
      _showErrorSnackBar("Please fill all the fields");
    } else if (usedUsername.contains(_usernameController.text)) {
      _showErrorSnackBar("Username already used");
    } else {
      await user_services.updateUser(
        user_services.currentUser!.id,
        username: _usernameController.text,
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        city: _selectedCity!,
        profilePicture: await _profilePicture?.readAsBytes(),
      );
      Modular.to.pop();
    }
  }

  void _showErrorSnackBar(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
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
  void initState() {
    super.initState();

    _usernameController.text = _user.username;
    _fullNameController.text = _user.fullName;
    _phoneNumberController.text = _user.phoneNumber;
    _selectedCity = _user.city;
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(
                "Update Akun",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 75.0,
                    backgroundImage: _profilePicture != null
                        ? kIsWeb
                            ? NetworkImage(_profilePicture!.path)
                            : FileImage(File(_profilePicture!.path))
                                as ImageProvider
                        : user_services.currentUser!.getProfilePicture(),
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
                          onTap: () => kIsWeb
                              ? _pickImage(ImageSource.gallery)
                              : showModalBottomSheet(
                                  backgroundColor: kBackgroundColor,
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  builder: (context) =>
                                      DraggableScrollableSheet(
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
                                                onTap: () async {
                                                  await _pickImage(
                                                    ImageSource.camera,
                                                  );
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 90.0),
                                                child: PictureSelectButton(
                                                  icon: Icons.image,
                                                  text: "Gallery",
                                                  onTap: () async {
                                                    await _pickImage(
                                                      ImageSource.gallery,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.5),
                            ),
                            child: const Icon(
                              Icons.edit_outlined,
                              size: 35.0,
                              color: kPinkColor,
                            ),
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
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "_username",
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
                    controller: _fullNameController,
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
                    controller: _phoneNumberController,
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
                  child: DropdownButtonFormField<String>(
                    value: _selectedCity,
                    iconSize: 0.0,
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    hint: const Text(
                      "kota",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(
                        () {
                          _selectedCity = value!;
                        },
                      );
                    },
                    items: cityList.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14.0,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: UnconstrainedBox(
              child: CircleButton(
                text: const Text(
                  "Simpan",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                color: kPinkColor,
                height: 25.0,
                width: 115.0,
                onTap: () async {
                  await _update();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
