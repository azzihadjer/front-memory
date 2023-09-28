import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_main/controller/user_service.dart';
import 'package:memory_main/pages/profile.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  bool showPassword = false;
  bool showPassword1 = false;
  bool showPassword2 = false;
  final auth = Authentification();
  TextEditingController oldPasswordController = TextEditingController(),
      newPasswordController = TextEditingController(),
      confirmPasswordController = TextEditingController();
  String get oldPassword => oldPasswordController.text;
  String get newPassword => newPasswordController.text;
  String get confirmPassword => confirmPasswordController.text;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Edit Password'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offAll(const ProfileUser());
            },
          )),
      body: Container(
        margin: const EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              obscureText: !showPassword,
              controller: oldPasswordController,
              decoration: InputDecoration(
                labelText: 'Old Password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            TextFormField(
              obscureText: !showPassword1,
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPassword1 = !showPassword1;
                    });
                  },
                  child: Icon(
                    showPassword1 ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            TextFormField(
              obscureText: !showPassword2,
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPassword2 = !showPassword2;
                    });
                  },
                  child: Icon(
                    showPassword2 ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            const SizedBox(
                height: 20), // Added space between text fields and button
            ElevatedButton(
              onPressed: () async {
                Future<void> success = auth.updatePassworduser(
                  oldPassword,
                  newPassword,
                  confirmPassword,
                );
                // ignore: unrelated_type_equality_checks
                if (success == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Password updated successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to update password')),
                  );
                }
              },
              child: const Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
