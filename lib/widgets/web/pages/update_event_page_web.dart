import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:textfield_tags/textfield_tags.dart';

import '../../../constants.dart';
import '../../../models/event_model.dart';
import '../../../services/event_services.dart';
import '../../universal/fields/tags_field.dart';
import 'web_scaffold.dart';

class UpdateEventPageWeb extends StatefulWidget {
  final String eventId;

  const UpdateEventPageWeb({required this.eventId, super.key});

  @override
  State<UpdateEventPageWeb> createState() => _UpdateEventPageWebState();
}

class _UpdateEventPageWebState extends State<UpdateEventPageWeb> {
  EventModel? _event;
  CroppedFile? _coverImage;
  String? _selectedCity;

  final _eventNameController = TextEditingController();
  final _quillController = QuillController.basic();

  late double _distanceToField;
  DateTime _startDate = DateTime.now();

  final TextEditingController _startDateController = TextEditingController();
  final StringTagController _tagsController = StringTagController();

  void _fetchEvent() {
    getEvent(widget.eventId).then((data) {
      setState(() {
        _event = data.data()!;
        _eventNameController.text = _event!.eventName;
        _quillController.document =
            Document.fromJson(jsonDecode(_event!.description));
        _startDate = _event!.startDate;
        _startDateController.text =
            intl.DateFormat.yMd().add_Hm().format(_startDate);
        _selectedCity = _event!.city;
      });
    });
  }

  Future<void> _pickImage(ImageSource source) async {
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
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      compressQuality: 1000,
      uiSettings: [
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
        _startDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        _startDateController.text =
            intl.DateFormat.yMd().add_Hm().format(_startDate);
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

  Future<void> _updateEvent() async {
    if (_eventNameController.text.isEmpty ||
        _coverImage == null ||
        _quillController.document.isEmpty() ||
        _selectedCity == null ||
        _tagsController.getTags!.isEmpty) {
      _showErrorSnackBar("Semua field harus diisi");
    } else if (_startDate.isBefore(DateTime.now())) {
      _showErrorSnackBar("Tanggal Mulai Event tidak valid");
    } else {
      await updateEvent(
        widget.eventId,
        eventName: _eventNameController.text,
        coverImage: await _coverImage!.readAsBytes(),
        startDate: _startDate,
        city: _selectedCity!,
        description: jsonEncode(_quillController.document.toDelta().toJson()),
        tags: _tagsController.getTags!,
      );
      Modular.to.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedCity = cityList[0];
    _startDateController.text =
        intl.DateFormat.yMd().add_Hm().format(_startDate);
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
    _eventNameController.dispose();
    _startDateController.dispose();
    _tagsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      showFlexible: false,
      actions: [
        IconButton(
          onPressed: () => _updateEvent(),
          icon: const Icon(Icons.save),
        )
      ],
      body: Builder(
        builder: (context) {
          if (_event == null) {
            _fetchEvent();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildPage(_event!);
          }
        },
      ),
    );
  }

  Widget _buildPage(EventModel event) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 2,
          child: Form(
            child: Column(
              children: [
                Material(
                  child: InkWell(
                    child: Ink.image(
                      height: 270,
                      width: 270,
                      image: NetworkImage(event.coverImageUrl),
                      fit: BoxFit.cover,
                    ),
                    onTap: () async {
                      await _pickImage(ImageSource.gallery);
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
                  child: TextFormField(
                    controller: _eventNameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nama Event",
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
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
                  child: Row(
                    children: [
                      const Text(
                        "Tanggal Mulai Event: ",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16.0,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _startDateController,
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
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
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
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
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
                        child: TagsField(
                          tagsController: _tagsController,
                          distanceToField: _distanceToField,
                          initialTags: event.tags,
                          validator: (String tags) {
                            if (_tagsController.getTags!.contains(tags)) {
                              _showErrorSnackBar("Tag sudah ada");
                              return "";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          child: Column(
            children: [
              QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: _quillController,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('id'),
                  ),
                ),
              ),
              Expanded(
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    scrollable: true,
                    controller: _quillController,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('id'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
