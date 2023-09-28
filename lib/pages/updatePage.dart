import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_main/controller/post_service.dart';
import 'package:memory_main/models/PostModel.dart';
import 'package:memory_main/pages/Posts.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key, required this.post}) : super(key: key);

  final PostModel post;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> selectedImages = [];

  String get title => titleController.text;
  String get description => descriptionController.text;

  ManagePost manage = ManagePost();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.post.title;
    descriptionController.text = widget.post.description;
    selectedImages =
        widget.post.images.map((image) => image.imagesPost).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f1e9),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFBFFFC7),
                          Color(0xFFf9e866),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xff578f53)),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color(0xFF7DBD72),
                              size: 15,
                            ),
                            onPressed: () {
                              Get.offAll(const Posts());
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Select Image Source',
                            style: TextStyle(
                              color: Color(0xFF7DBD72),
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                GestureDetector(
                                  child: const Text(
                                    'Gallery',
                                    style: TextStyle(
                                      color: Color(0xFF7DBD72),
                                    ),
                                  ),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    final List<XFile> images =
                                        await _picker.pickMultiImage();
                                    setState(() {
                                      selectedImages = images
                                          .map((image) => image.path)
                                          .toList();
                                    });
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                GestureDetector(
                                  child: const Text(
                                    'Camera',
                                    style: TextStyle(
                                      color: Color(0xFF7DBD72),
                                    ),
                                  ),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    final XFile? image = await _picker
                                        .pickImage(source: ImageSource.camera);
                                    if (image != null) {
                                      setState(() {
                                        selectedImages = [image.path];
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: selectedImages.isEmpty
                      ? const Text(
                          'Tap to select images',
                          style: TextStyle(
                            color: Color(0xFF7DBD72),
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: selectedImages.map((image) {
                            if (image.startsWith('http') ||
                                image.startsWith('https')) {
                              return Image.network(
                                image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              );
                            } else {
                              return Image.file(
                                File(image),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              );
                            }
                          }).toList(),
                        ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Color(0xFF7DBD72),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF7DBD72),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF7DBD72),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: Color(0xFF7DBD72),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF7DBD72),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF7DBD72),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                width: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFBFFFC7),
                      Color(0xFFf9e866),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      manage.updatePost(
                        widget.post.id,
                        title,
                        description,
                        selectedImages,
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    splashColor: const Color(0xFF7DBD72),
                    child: const Center(
                      child: Text(
                        'Update Post',
                        style: TextStyle(
                          color: Color(0xFF7DBD72),
                          fontWeight: FontWeight.w700,
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
    );
  }
}
