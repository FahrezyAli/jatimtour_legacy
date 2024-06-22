import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';
import '../../../services/user_services.dart';
import '../../universal/buttons/circle_button.dart';

class ProfileViewWeb extends StatefulWidget {
  const ProfileViewWeb({super.key});

  @override
  State<ProfileViewWeb> createState() => _ProfileViewWebState();
}

class _ProfileViewWebState extends State<ProfileViewWeb> {
  CroppedFile? _profilePicture;
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? _selectedCity;

  final _user = currentUser!;
  bool _editable = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final croppedImage = await _cropImage(File(pickedImage.path));
      setState(
        () {
          if (croppedImage != null) {
            _profilePicture = croppedImage;
          }
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
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
        )
      ],
    );
    if (croppedImage != null) {
      return croppedImage;
    }
    return null;
  }

  String _getRole() {
    switch (currentUser!.role) {
      case 0:
        return "User";
      case 1:
        return "Event Organizer";
      case 2:
        return "Admin";
      default:
        return "User";
    }
  }

  Future<void> _update() async {
    final usedUsername = await getUsedUsername();
    usedUsername.remove(currentUser!.username);
    if (_usernameController.text == "" ||
        _fullNameController.text == "" ||
        _phoneNumberController.text == "" ||
        _selectedCity == "") {
      _showErrorSnackBar("Please fill all the fields");
    } else if (usedUsername.contains(_usernameController.text)) {
      _showErrorSnackBar("Username already used");
    } else {
      await updateUser(
        currentUser!.id,
        username: _usernameController.text,
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        city: _selectedCity!,
        profilePicture: await _profilePicture?.readAsBytes(),
      );
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
    return Column(
      children: [
        Material(
          color: Colors.white,
          elevation: 5.0,
          child: Ink(
            width: double.infinity,
            height: 50,
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      '${_user.fullName} <${_user.email}>',
                      style:
                          const TextStyle(fontSize: 20.0, fontFamily: "Inter,"),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: CircleButton(
                        text: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _editable
                                  ? Icons.save_outlined
                                  : Icons.edit_outlined,
                              color: Colors.white,
                              size: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                _editable ? "Save" : "Edit",
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        color: kPinkColor,
                        height: 30.0,
                        width: 75.0,
                        radius: 5.0,
                        onTap: () {
                          setState(
                            () {
                              if (_editable) {
                                _update();
                              }
                              _editable = !_editable;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0),
            child: Material(
              color: Colors.white,
              elevation: 5.0,
              child: Ink(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: LayoutBuilder(
                    builder: (context, constraints) => Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _header(constraints),
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 50.0),
                            child: Text(
                              "Account",
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _accountBox(constraints),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _header(BoxConstraints constraints) {
    return Row(
      children: [
        SizedBox(
          width: constraints.maxWidth / 3,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 20.0,
              ),
              child: CircleAvatar(
                backgroundImage: _user.getProfilePicture(),
                radius: 100.0,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: _user.fullName,
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontFamily: "Inter",
                    ),
                    children: [
                      TextSpan(
                        text: "\n\n${_user.email}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Inter",
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: " - ${_getRole()}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Inter",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      CircleButton(
                        text: const Text(
                          "Update Foto",
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
                          await _pickImage(
                            ImageSource.gallery,
                          );
                          if (_profilePicture != null) {
                            await updateProfilePicture(
                              _user.id,
                              profilePicture:
                                  await _profilePicture!.readAsBytes(),
                            );
                            setState(() {});
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: CircleButton(
                          text: const Text(
                            "Ubah Password",
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
                          onTap: () {
                            Modular.to.pushNamed(changePasswordRoute);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _accountBox(BoxConstraints constraints) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              right: constraints.maxWidth / 3,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: constraints.maxWidth / 3,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFFCFCFC),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPurpleColor,
                            width: 1.0,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      controller: _usernameController,
                      enabled: _editable,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              right: constraints.maxWidth / 3,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: constraints.maxWidth / 3,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFFCFCFC),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPurpleColor,
                            width: 1.0,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      controller: _fullNameController,
                      enabled: _editable,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              right: constraints.maxWidth / 3,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: constraints.maxWidth / 3,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFFCFCFC),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPurpleColor,
                            width: 1.0,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      controller: _phoneNumberController,
                      enabled: _editable,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              right: constraints.maxWidth / 3,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: constraints.maxWidth / 3,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "City",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFFCFCFC),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPurpleColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      value: _selectedCity,
                      items: cityList
                          .map(
                            (city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ),
                          )
                          .toList(),
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Inter",
                      ),
                      onChanged: _editable
                          ? (String? value) {
                              setState(
                                () {
                                  _selectedCity = value;
                                },
                              );
                            }
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
