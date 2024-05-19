import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/article_model.dart';
import 'package:jatimtour/widgets/buttons/circle_button.dart';
import 'package:jatimtour/widgets/mobile/pages/mobile_scaffold.dart';
import 'package:textfield_tags/textfield_tags.dart';

class CreateArticlePageMobile extends StatefulWidget {
  const CreateArticlePageMobile({super.key});

  @override
  State<CreateArticlePageMobile> createState() =>
      _CreateArticlePageMobileState();
}

class _CreateArticlePageMobileState extends State<CreateArticlePageMobile> {
  CroppedFile? _coverImage;

  final _quillController = QuillController.basic();
  final _titleController = TextEditingController();

  Future _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final croppedImage = await _cropImage(File(pickedImage.path));
      setState(
        () {
          if (croppedImage != null) {
            _coverImage = croppedImage;
          }
        },
      );
    }
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 2.0, ratioY: 1.0),
      cropStyle: CropStyle.rectangle,
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
              const CroppieViewPort(width: 300, height: 300, type: 'rectangle'),
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

  Future<void> _continue() async {
    if (_titleController.text.isEmpty ||
        _coverImage == null ||
        _quillController.document.isEmpty()) {
      _showErrorSnackBar("Semua field harus diisi");
    } else {
      Modular.to.pushNamed(
        '$createArticleRoute/cont',
        arguments: {
          'coverImage': _coverImage,
          'titleController': _titleController,
          'quillController': _quillController,
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _quillController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      actions: [
        IconButton(
            onPressed: () => _continue(), icon: const Icon(Icons.arrow_right))
      ],
      body: Form(
        child: Column(
          children: [
            Container(
              height: 180,
              width: 360,
              color: const Color(0xFFD9D9D9),
              child: Builder(
                builder: (context) {
                  if (_coverImage == null) {
                    return Center(
                      child: CircleButton(
                        text: const Text("Tambah Gambar"),
                        color: const Color(0xFFD9D9D9),
                        width: 125.0,
                        elevation: 0.0,
                        border: Border.all(color: Colors.black, width: 1.0),
                        onTap: () => _pickImage(ImageSource.gallery),
                      ),
                    );
                  } else {
                    return kIsWeb
                        ? Image.network(_coverImage!.path)
                        : Image.file(File(_coverImage!.path));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Judul Artikel",
                  hintStyle: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: _quillController,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('id'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: _quillController,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('id'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateArticlePageMobileCont extends StatefulWidget {
  final TextEditingController titleController;
  final CroppedFile coverImage;
  final QuillController quillController;

  const CreateArticlePageMobileCont(
      this.coverImage, this.titleController, this.quillController,
      {super.key});

  @override
  State<CreateArticlePageMobileCont> createState() =>
      _CreateArticlePageMobileContState();
}

class _CreateArticlePageMobileContState
    extends State<CreateArticlePageMobileCont> {
  String? _selectedCity;
  late double _distanceToField;
  DateTime _datePublished = DateTime.now();

  final TextEditingController _datePublishedController =
      TextEditingController();
  final StringTagController _tagsController = StringTagController();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    final TimeOfDay? time = await showTimePicker(
      // ignore: use_build_context_synchronously
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && time != null) {
      setState(() {
        _datePublished = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        _datePublishedController.text =
            DateFormat.yMd().add_Hm().format(_datePublished);
      });
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

  Future<void> _saveArticle() async {
    if (_selectedCity == null || _tagsController.getTags!.isEmpty) {
      _showErrorSnackBar("Semua field harus diisi");
    } else {
      await ArticleModel().setData(
        title: widget.titleController.text,
        coverImage: widget.coverImage,
        datePublished: _datePublished,
        city: _selectedCity!,
        content: jsonEncode(widget.quillController.document.toDelta().toJson()),
        tags: _tagsController.getTags!,
      );
      Modular.to.pop();
      Modular.to.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedCity = cityList[0];
    _datePublishedController.text =
        DateFormat.yMd().add_Hm().format(_datePublished);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _datePublishedController.dispose();
    _tagsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileScaffold(
      actions: [
        IconButton(
            onPressed: () => _saveArticle(), icon: const Icon(Icons.save))
      ],
      body: Form(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
              child: Row(
                children: [
                  const Text("Tanggal Publikasi: ",
                      style: TextStyle(fontFamily: "Inter", fontSize: 16.0)),
                  Expanded(
                    child: TextFormField(
                      controller: _datePublishedController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () => _selectDate(),
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
              child: Row(
                children: [
                  const Text("Kota: ",
                      style: TextStyle(fontFamily: "Inter", fontSize: 16.0)),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCity,
                      isDense: false,
                      iconSize: 0.0,
                      decoration: const InputDecoration.collapsed(hintText: ''),
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
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
              child: Row(
                children: [
                  const Text("Tags: ",
                      style: TextStyle(fontFamily: "Inter", fontSize: 16.0)),
                  Expanded(
                    child: TextFieldTags<String>(
                      textfieldTagsController: _tagsController,
                      textSeparators: const [' ', ','],
                      letterCase: LetterCase.normal,
                      validator: (String tag) {
                        if (_tagsController.getTags!.contains(tag)) {
                          _showErrorSnackBar("Tag sudah ada");
                          return "";
                        }
                        return null;
                      },
                      inputFieldBuilder: (context, inputFieldValues) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: inputFieldValues.textEditingController,
                            focusNode: inputFieldValues.focusNode,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIconConstraints: BoxConstraints(
                                  maxWidth: _distanceToField * 0.5),
                              prefixIcon: inputFieldValues.tags.isNotEmpty
                                  ? SingleChildScrollView(
                                      controller:
                                          inputFieldValues.tagScrollController,
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: inputFieldValues.tags.map(
                                          (String tag) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0),
                                                ),
                                                color: kPinkColor,
                                              ),
                                              margin: const EdgeInsets.only(
                                                  right: 10.0),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    child: Text(
                                                      '#$tag',
                                                      style: const TextStyle(
                                                          fontFamily: 'Inter',
                                                          fontSize: 14.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4.0),
                                                  InkWell(
                                                    child: const Icon(
                                                      Icons.cancel,
                                                      size: 14.0,
                                                      color: Color.fromARGB(
                                                          255, 233, 233, 233),
                                                    ),
                                                    onTap: () {
                                                      inputFieldValues
                                                          .onTagRemoved(tag);
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    )
                                  : null,
                            ),
                            onChanged: inputFieldValues.onTagChanged,
                            onSubmitted: inputFieldValues.onTagSubmitted,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
