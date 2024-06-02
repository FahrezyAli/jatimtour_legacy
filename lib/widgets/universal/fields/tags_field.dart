import 'package:flutter/material.dart';
import 'package:jatimtour/constants.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TagsField extends StatelessWidget {
  final StringTagController tagsController;
  final double distanceToField;
  final List<String>? initialTags;
  final String? Function(String tags)? validator;

  const TagsField({
    required this.tagsController,
    required this.distanceToField,
    this.initialTags,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldTags<String>(
      textfieldTagsController: tagsController,
      initialTags: initialTags,
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: validator,
      inputFieldBuilder: (context, inputFieldValues) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            controller: inputFieldValues.textEditingController,
            focusNode: inputFieldValues.focusNode,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints:
                  BoxConstraints(maxWidth: distanceToField * 0.5),
              prefixIcon: inputFieldValues.tags.isNotEmpty
                  ? SingleChildScrollView(
                      controller: inputFieldValues.tagScrollController,
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
                              margin: const EdgeInsets.only(right: 10.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      color: Color.fromARGB(255, 233, 233, 233),
                                    ),
                                    onTap: () {
                                      inputFieldValues.onTagRemoved(tag);
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
    );
  }
}
