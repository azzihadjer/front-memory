import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_main/models/User.dart';

import 'package:memory_main/pages/Posts.dart';
import 'package:memory_main/controller/user_service.dart';
import 'package:memory_main/pages/edit_profile.dart';
import 'package:memory_main/pages/editpassword_.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  final Authentification auth = Authentification();
  UserModel? currentUser;
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
        });
      }).catchError((error) {
        // Handle error when fetching user info
        print(error.toString());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(const Posts());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 70),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 55,
                    child: ClipOval(
                      child: Image.network(
                        currentUser?.profileImg ??
                            'https://static.wikia.nocookie.net/naruto/images/7/7d/Sasuke%27s_Rinnegan.png/revision/latest?cb=20160909022555',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentUser?.username ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(width: 15),
                      Text(
                        currentUser?.email ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      // const SizedBox(width: 33),          
                      /* const Icon(Icons.phone),
                      const SizedBox(width: 15),
                      Text(
                        currentUser?.phoneNumber ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),*/
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 15),
                      Text(
                        currentUser?.phoneNumber ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 7),
                      const Text(
                        'Location:',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(currentUser?.wilaya ?? ''),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(width: 7),
                      const Text(
                        'Type of Job:',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(currentUser?.typeJob ?? ''),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(Icons.build),
                      const SizedBox(width: 7),
                      const Text(
                        'Name Service:',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(currentUser?.nameService ?? ''),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(const EditPassword());
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.password_sharp),
                        SizedBox(width: 7),
                        Text(
                          'Password:',
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Change Password',
                          style: TextStyle(
                            color: Colors.blue,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAll(EditProfile());
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
