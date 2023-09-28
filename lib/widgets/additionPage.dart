import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_main/controller/post_service.dart';

import 'package:memory_main/pages/Posts.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> selectedImages = [];
  List<File> selectedImageFiles = [];
  String get title => titleController.text;
  String get description => descriptionController.text;

  ManagePost manage = ManagePost();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f1e9),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Row(
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
                          child: IconButton(
                            onPressed: () {
                              Get.offAll(const Posts());
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color(0xff578f53),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  child: Container(
                    // margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 0.0,
                        ),
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
                                              final List<XFile>? images =
                                                  await _picker
                                                      .pickMultiImage();
                                              if (images != null) {
                                                setState(() {
                                                  selectedImages = images
                                                      .map(
                                                          (image) => image.path)
                                                      .toList();
                                                });
                                              }
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

                                              final XFile? image =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.camera);
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
                            child: Container(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: const Color(0xFF7DBD72)),
                                  shape: BoxShape.circle,
                                ),
                                height: 150.0,
                                width: 150.0,
                                child: const Center(
                                  child: Icon(
                                    Icons.add_photo_alternate,
                                    size: 50,
                                    color: Color(0xFF7DBD72),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0.0),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF7DBD72),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: descriptionController,
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                  labelStyle: TextStyle(
                                      color: Color(0xFF7DBD72),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              SizedBox(
                                height:
                                    200, // Adjust the height according to your needs
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: selectedImages.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: FileImage(
                                              File(selectedImages[index])),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 0.0),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 5),
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
                                      manage.createPosts(
                                          title, description, selectedImages);
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    splashColor: const Color(0xFF7DBD72),
                                    child: const Center(
                                      child: Text(
                                        'CREATE',
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
                      ],
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
