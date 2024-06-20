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

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  CroppedFile? _profilePicture;
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? _selectedCity;
  bool _isAcceptTerms = false;

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
        )
      ],
    );
    if (croppedImage != null) {
      return croppedImage;
    }
    return null;
  }

  Future<void> _register() async {
    final usedUsername = await user_services.getUsedUsername();
    if (_usernameController.text == "" ||
        _fullNameController.text == "" ||
        _phoneNumberController.text == "" ||
        _selectedCity == null) {
      _showErrorSnackBar("Please fill all the fields");
    } else if (!_isAcceptTerms) {
      _showErrorSnackBar("Please accept the terms and conditions");
    } else if (usedUsername.contains(_usernameController.text)) {
      _showErrorSnackBar("Username already used");
    } else {
      await user_services.register(
        username: _usernameController.text,
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        city: _selectedCity!,
        profilePicture: await _profilePicture?.readAsBytes(),
      );
      Modular.to.navigate(kIsWeb ? rootRoute : mHomeRoute);
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
                  CircleAvatar(
                    radius: 75.0,
                    backgroundImage: _profilePicture != null
                        ? kIsWeb
                            ? NetworkImage(_profilePicture!.path)
                            : FileImage(File(_profilePicture!.path))
                                as ImageProvider
                        : const AssetImage('assets/images/placeholder.png'),
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
                    keyboardType: TextInputType.name,
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
                    keyboardType: TextInputType.name,
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
                    keyboardType: TextInputType.phone,
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
            padding: const EdgeInsets.only(top: 15.9),
            child: UnconstrainedBox(
              child: Center(
                child: Row(
                  children: [
                    Checkbox(
                      side: const BorderSide(
                        color: kPinkColor,
                        width: 2.0,
                      ),
                      fillColor: WidgetStateProperty.resolveWith(
                        ((states) {
                          const Set<WidgetState> interactiveStates =
                              <WidgetState>{
                            WidgetState.pressed,
                            WidgetState.hovered,
                            WidgetState.focused,
                          };
                          if (states.any(interactiveStates.contains) ||
                              _isAcceptTerms) {
                            return kPinkColor;
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
                              color: kPinkColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: " dan "),
                          TextSpan(
                            text: "Ketentuan",
                            style: TextStyle(
                              color: kPinkColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.9),
            child: UnconstrainedBox(
              child: CircleButton(
                text: const Text(
                  "Buat Akun",
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
                  await _register();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
