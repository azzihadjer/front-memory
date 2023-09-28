import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_main/controller/user_service.dart';
import 'package:memory_main/models/User.dart';
import 'package:memory_main/pages/profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final auth = Authentification();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController wilayaController = TextEditingController();

  UserModel? currentUser;
  String profileImageUrl = '';

  File? selectedImageFile;
  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    try {
      await auth.getDetailsUser().then((user) {
        setState(() {
          currentUser = user;
          usernameController.text = currentUser!.username;
          emailController.text = currentUser!.email;
          phoneNumberController.text = currentUser!.phoneNumber;
          wilayaController.text = currentUser!.wilaya;
          profileImageUrl = currentUser!.profileImg;
        });
      }).catchError((error) {
        // Handle error when fetching user info
        print(error.toString());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _selectImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(const ProfileUser());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 92),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                  controller: usernameController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  controller: emailController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  controller: phoneNumberController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Wilaya',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  controller: wilayaController,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    _selectImageFromGallery();
                  },
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: selectedImageFile != null
                          ? DecorationImage(
                              image: FileImage(selectedImageFile!),
                              fit: BoxFit.cover,
                            )
                          : currentUser != null &&
                                  currentUser!.profileImg.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(currentUser!.profileImg),
                                  fit: BoxFit.cover,
                                )
                              : null,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      String username = usernameController.text;
                      String email = emailController.text;
                      String phoneNumber = phoneNumberController.text;
                      String wilaya = wilayaController.text;
                      String? imagePath = selectedImageFile?.path;

                      auth.updateUserProfile(
                        username,
                        email,
                        phoneNumber,
                        wilaya,
                        imagePath,
                      );
                    },
                    child: const Text(
                      'Update Profile',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
