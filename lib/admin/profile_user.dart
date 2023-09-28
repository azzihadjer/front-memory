import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_main/admin/admin_page.dart';
import 'package:memory_main/models/User.dart';

class ProfileAnotherUserAdmin extends StatefulWidget {
  const ProfileAnotherUserAdmin({Key? key, required this.user})
      : super(key: key);
  final UserModel user;
  @override
  State<ProfileAnotherUserAdmin> createState() =>
      _ProfileAnotherUserAdminState();
}

class _ProfileAnotherUserAdminState extends State<ProfileAnotherUserAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(const AdminHome());
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 92),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              CircleAvatar(
                // Use the profileImg from the currentUser
                radius: 80,
                child: Image.network(
                  widget.user.profileImg,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.user.username,
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
                    widget.user.email,
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
                    widget.user.phoneNumber,
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
                  Text(widget.user.wilaya),
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
                  Text(widget.user.typeJob),
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
                  Text(widget.user.nameService),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
