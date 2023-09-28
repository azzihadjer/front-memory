// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:memory_main/models/User.dart';
import 'package:memory_main/pages/Posts.dart';
import 'package:path/path.dart' as path;
import 'package:memory_main/pages/login_page.dart';
import 'package:memory_main/constants/constants.dart';
import 'package:memory_main/pages/profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Authentification extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();
  final storage = const FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(loginURL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      switch (response.statusCode) {
        case 200:
          isLoading.value = false;
          token.value = json.decode(response.body)['token'];
          box.write('token', token.value);

          Get.offAll(() => const Posts());
          break;

        default:
          print(json.decode(response.body)['message']);
          print(json.decode(response.body)['comment']);

          break;
      }
    } catch (e) {
      isLoading.value = false;

      print(e.toString());
    }
  }

  static Future<void> register(
    String username,
    String email,
    String password,
    String phoneNumber,
    String wilaya,
    String profileImg,
    String typeJob,
    String nameService,
  ) async {
    final response = await http.post(
      Uri.parse(registerURL),
      headers: {'Accept': 'application/json'},
      body: {
        'username': username,
        'email': email,
        'password': password,
        'phone_number': phoneNumber,
        'wilaya': wilaya,
        'profile_img': profileImg,
        'type_job': typeJob,
        'name_service': nameService,
      },
    );

    if (response.statusCode == 200) {
      Get.offAll(() => const LoginPage());
    } else {
      print(json.decode(response.body)['message']);
    }
  }

  Future<UserModel> getDetailsUser() async {
    final response = await http.get(
      Uri.parse(userURL), // Replace with the URL of your user info route
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      return UserModel.fromJson(userData['user']);
    } else {
      // Handle error when fetching user info
      print(json.decode(response.body)['message']);
      throw Exception('Failed to fetch current user');
    }
  }

  Future<void> logout() async {
    final response = await http.post(
      Uri.parse(logoutUrl), // Replace with your logout route URL
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 200) {
      // Logout successful, remove token locally
      box.remove('token');
      Get.offAll(const LoginPage()); // Navigate to the login page
    } else {
      // Logout failed, handle error
      print(json.decode(response.body)['message']);
    }
  }

  Future<int?> getUserId() async {
    try {
      final url = Uri.parse(userURL);
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        UserModel user = UserModel.fromJson(responseData['user']);
        int userId = user.id;
        return userId;
      } else {
        // Handle the error case when the API request is unsuccessful
        // You can throw an exception or return null depending on your needs
        throw Exception('Failed to get user ID');
      }
    } catch (e) {
      // Handle any other exceptions that might occur during the API request
      print('Error: $e');
      return null;
    }
  }

// Function to update the user profile

  Future<void> updateUserProfile(
    String username,
    String email,
    String phoneNumber,
    String wilaya,
    String? profileImg,
  ) async {
    try {
      int? userId = await getUserId();

      if (userId == null) {
        // Handle the case where user ID is not available
        return;
      }

      final url = Uri.parse('$modifyUserURL/$userId');
      final request = http.MultipartRequest('POST', url);

      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${box.read('token')}';

      request.fields['username'] = username;
      request.fields['email'] = email;
      request.fields['phone_number'] = phoneNumber;
      request.fields['wilaya'] = wilaya;

      if (profileImg != null) {
        File imageFile = File(profileImg);
        String fileName = path.basename(imageFile.path);

        request.files.add(await http.MultipartFile.fromPath(
          'profile_img',
          imageFile.path,
          filename: fileName,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle the successful update
        Get.offAll(ProfileUser());
        print('User profile updated successfully');
      } else {
        // Handle the error
        print('Failed to update user profile');
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      // Handle any other errors
      print('Failed to update user profile');
      print(e.toString());
    }
  }

  Future<void> updatePassworduser(
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    int? userId = await getUserId();

    if (userId == null) {
      // Handle the case where user ID is not available
      return;
    }
    final url = Uri.parse('$modifyPasswordURL/$userId');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: {
        'old_password': oldPassword,
        'password': newPassword,
        'confirm_password': confirmPassword,
      },
    );
    if (response.statusCode == 200) {
      // Handle the successful update
      Get.offAll(const ProfileUser());
      print('User profile updated successfully');
    } else {
      // Handle the error
      print('Failed to update user profile');
      print(response.body);
    }
  }

  String? getStringImage(File? file) {
    if (file == null) return null;
    return base64Encode(file.readAsBytesSync());
  }
}
