import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:ibra_jt/article/ArticleData.dart';
import 'package:provider/provider.dart';
import 'package:ibra_jt/article/Article.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditArticlePage extends StatefulWidget {
  final Article article;
  final bool isNewArticle;

  const EditArticlePage({
    Key? key,
    required this.article,
    required this.isNewArticle,
  }) : super(key: key);

  @override
  State<EditArticlePage> createState() => _EditArticlePageState();
}

class _EditArticlePageState extends State<EditArticlePage> {
  QuillController _controller = QuillController.basic();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery, // Use gallery as the image source
    );

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    loadExistingArticle();
  }

  void loadExistingArticle() {
    final doc = Document()..insert(0, widget.article.text);
    setState(() {
      _controller = QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );
    });
  }

  void addNewArticle() {
    int id = Provider.of<ArticleData>(context, listen: false)
        .getAllArticles()
        .length;
    String text = _controller.document.toPlainText();
    Provider.of<ArticleData>(context, listen: false).addNewArticle(
      Article(id: id, text: text, hashtags: text), // Use text as hashtags
    );
  }

  void updateArticle() {
    String text = _controller.document.toPlainText();
    Provider.of<ArticleData>(context, listen: false)
        .updateArticle(widget.article, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.isNewArticle && !_controller.document.isEmpty()) {
              addNewArticle();
            } else {
              updateArticle();
            }
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            color: Colors.grey,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: _imageFile != null
                        ? Container(
                            height: 180,
                            width: double.infinity,
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Text(''),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: 50,
                  left: 50,
                  child: Container(
                    width: 30,
                    height: 50,
                    child: FloatingActionButton(
                      onPressed: _pickImage,
                      child: Text(
                        'Tambah Gambar',
                        style: TextStyle(fontFamily: 'Inter-Reg'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: _controller,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('de'),
                  ),
                ),
              ),
              Expanded(
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: _controller,
                    readOnly: false,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('de'),
                    ),
                  ),
                ),
              )
            ],
          )

          // QuillProvider(
          //   configurations: QuillConfigurations(
          //     controller: _controller,
          //     sharedConfigurations: const QuillSharedConfigurations(),
          //   ),
          //   child: Column(
          //     children: [
          //       const QuillToolbar(),
          //       Expanded(
          //         child: QuillEditor.basic(
          //           configurations: const QuillEditorConfigurations(
          //             readOnly: false,
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
