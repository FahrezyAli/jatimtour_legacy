import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/buttons/picture_select_button.dart';
import 'package:jatimtour/widgets/mobile/pages/main_page_mobile.dart';
import 'package:jatimtour/widgets/buttons/circle_button.dart';
import 'package:jatimtour/models/user_model.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  CroppedFile? _profilePicture;
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
          kIsWeb ? null : Navigator.of(context).pop();
        },
      );
    }
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      cropStyle: CropStyle.circle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: kPinkColor,
        ),
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(width: 350, height: 350),
          viewPort:
              const CroppieViewPort(width: 300, height: 300, type: 'circle'),
          enableExif: true,
          enableZoom: true,
          showZoomer: false,
        )
      ],
    );
    if (croppedImage != null) {
      return croppedImage;
    }
    return null;
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
                            ? Image.network(_profilePicture!.path).image
                            : FileImage(File(_profilePicture!.path))
                        : const AssetImage('assets/images/placeholder.png')
                            as ImageProvider<Object>?,
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
                                  backgroundColor: const Color(0xFFFFFBE2),
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
                    onChanged: (value) => _username = value,
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
                    onChanged: (value) => _fullName = value,
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
                    onChanged: (value) => _phoneNumber = value,
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
                    onChanged: (value) => _city = value,
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
                onTap: () {
                  final user = context.read<UserModel>();
                  user.setProfilePicture(_profilePicture!.readAsBytes());
                  user.setMetadata(
                    _username!,
                    _fullName!,
                    _city!,
                    _phoneNumber!,
                  );
                  kIsWeb
                      ? Navigator.pushReplacementNamed(context, "/")
                      : Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const MainPageMobile(),
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
