import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/article_model.dart';
import 'package:jatimtour/widgets/universal/buttons/circle_button.dart';
import 'package:jatimtour/widgets/web/pages/web_scaffold.dart';
import 'package:textfield_tags/textfield_tags.dart';

class CreateArticlePageWeb extends StatefulWidget {
  const CreateArticlePageWeb({super.key});

  @override
  State<CreateArticlePageWeb> createState() => _CreateArticlePageWebState();
}

class _CreateArticlePageWebState extends State<CreateArticlePageWeb> {
  CroppedFile? _coverImage;
  String? _selectedCity;

  final _titleController = TextEditingController();
  final _quillController = QuillController.basic();

  late double _distanceToField;
  DateTime _datePublished = DateTime.now();

  final TextEditingController _datePublishedController =
      TextEditingController();
  final StringTagController _tagsController = StringTagController();

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
      compressQuality: 100,
      uiSettings: [
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(width: 700, height: 350),
          viewPort:
              const CroppieViewPort(width: 600, height: 300, type: 'rectangle'),
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
            intl.DateFormat.yMd().add_Hm().format(_datePublished);
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
    if (_titleController.text.isEmpty ||
        _coverImage == null ||
        _quillController.document.isEmpty() ||
        _selectedCity == null ||
        _tagsController.getTags!.isEmpty) {
      _showErrorSnackBar("Semua field harus diisi");
    } else if (_datePublished.isBefore(DateTime.now())) {
      _showErrorSnackBar("Tanggal Publikasi tidak valid");
    } else {
      await ArticleModel().setData(
        title: _titleController.text,
        coverImage: _coverImage!,
        datePublished: _datePublished,
        city: _selectedCity!,
        content: jsonEncode(_quillController.document.toDelta().toJson()),
        tags: _tagsController.getTags!,
      );
      Modular.to.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedCity = cityList[0];
    _datePublishedController.text =
        intl.DateFormat.yMd().add_Hm().format(_datePublished);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _quillController.dispose();
    _titleController.dispose();
    _datePublishedController.dispose();
    _tagsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      actions: [
        IconButton(
            onPressed: () => _saveArticle(), icon: const Icon(Icons.save))
      ],
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: _coverImage == null
                ? Container(color: const Color(0xFFD9D9D9))
                : Image.network(
                    _coverImage!.path,
                    fit: BoxFit.cover,
                  ),
          ),
          // Opaque Layer
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            start: 225.0,
            end: 225.0,
            top: 0.0,
            bottom: 0.0,
            child: Material(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                        height: 50), // Add some top padding for better visual
                    _coverImage == null
                        ? Container(
                            height: 270,
                            width: 540,
                            color: const Color(0xFFD9D9D9),
                            child: Center(
                              child: CircleButton(
                                text: const Text("Tambah Gambar"),
                                color: const Color(0xFFD9D9D9),
                                width: 200.0,
                                elevation: 0.0,
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                onTap: () => _pickImage(ImageSource.gallery),
                              ),
                            ),
                          )
                        : Material(
                            child: InkWell(
                                child: Ink.image(
                                  height: 270,
                                  width: 540,
                                  image: Image.network(_coverImage!.path).image,
                                  fit: BoxFit.cover,
                                ),
                                onTap: () => _pickImage(ImageSource.gallery)),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20),
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 5.0, right: 10.0),
                      child: Row(
                        children: [
                          const Text(
                            "Tanggal Publikasi: ",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16.0,
                            ),
                          ),
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
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 5.0, right: 10.0),
                      child: Row(
                        children: [
                          const Text(
                            "Kota: ",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16.0,
                            ),
                          ),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedCity,
                              isDense: false,
                              iconSize: 0.0,
                              decoration:
                                  const InputDecoration.collapsed(hintText: ''),
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
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 5.0, right: 10.0),
                      child: Row(
                        children: [
                          const Text(
                            "Tags: ",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16.0,
                            ),
                          ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TextField(
                                    controller:
                                        inputFieldValues.textEditingController,
                                    focusNode: inputFieldValues.focusNode,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIconConstraints: BoxConstraints(
                                          maxWidth: _distanceToField * 0.5),
                                      prefixIcon: inputFieldValues
                                              .tags.isNotEmpty
                                          ? SingleChildScrollView(
                                              controller: inputFieldValues
                                                  .tagScrollController,
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children:
                                                    inputFieldValues.tags.map(
                                                  (String tag) {
                                                    return Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20.0),
                                                        ),
                                                        color: kPinkColor,
                                                      ),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      padding: const EdgeInsets
                                                          .symmetric(
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
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 4.0),
                                                          InkWell(
                                                            child: const Icon(
                                                              Icons.cancel,
                                                              size: 14.0,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      233,
                                                                      233,
                                                                      233),
                                                            ),
                                                            onTap: () {
                                                              inputFieldValues
                                                                  .onTagRemoved(
                                                                      tag);
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
                                    onSubmitted:
                                        inputFieldValues.onTagSubmitted,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.5,
                      ),
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          controller: _quillController,
                          sharedConfigurations: const QuillSharedConfigurations(
                            locale: Locale('id'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
