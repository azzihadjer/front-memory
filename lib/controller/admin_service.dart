import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:memory_main/admin/admin_page.dart';
import 'package:memory_main/models/PostModel.dart';
import 'package:memory_main/models/User.dart';

import 'package:memory_main/pages/login_page.dart';
import 'package:memory_main/constants/constants.dart';

class Admin extends GetxController {
  Rx<List<UserModel>> users = Rx<List<UserModel>>([]);
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  final isLoading = false.obs;
  final token = ''.obs;
  UserModel? currentUser;
  final box = GetStorage();

  Future<void> loginAdmin(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(loginAdminURL),
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

          Get.offAll(() => const AdminHome());
          break;

        default:
          print(json.decode(response.body)['message']);
          break;
      }
    } catch (e) {
      isLoading.value = false;

      print(e.toString());
    }
  }

  Future<void> logout() async {
    final response = await http.post(
      Uri.parse(logoutAdmintUrl), // Replace with your logout route URL
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 200) {
      // Logout successful, remove token locally
      box.remove('token');
      Get.offAll(LoginPage()); // Navigate to the login page
    } else {
      // Logout failed, handle error
      print(json.decode(response.body)['message']);
    }
  }

  Future<void> getAllPosts() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(getPostAdminURL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['post'];
        for (var item in content) {
          posts.value.add(PostModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future<void> getAlluser() async {
    try {
      users.value.clear();
      final response = await http.get(
        Uri.parse(getUserUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        final userData = json.decode(response.body);
        //print('Fetched data: $userData');
        final usersData = userData['users']; // Access the 'data' field
        // print('Users: $usersData');
        users.value = List<UserModel>.from(
            usersData.map((item) => UserModel.fromJson(item)));
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future<User> getAnotherUser(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$getAnotherUserURL/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final user = User.fromJson(jsonResponse['user']);
        return user;
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      throw Exception('Failed to fetch user');
    }
  }

  Future<void> DeleteUser(int id) async {
    try {
      isLoading.value = true;
      final response = await http.delete(
        Uri.parse('$DeleteUserURL/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        print(json.decode(response.body));
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      throw Exception('Failed to fetch user');
    }
  }

  Future<void> banUser(int id, String comment) async {
    try {
      isLoading.value = true;
      final response = await http.post(Uri.parse('$banUserURL/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      }, body: {
        'comment': comment
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        print(json.decode(response.body));
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      throw Exception('Failed to fetch user');
    }
  }

  Future<void> unbanUser(int id) async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse('$unbanUserURL/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        print(json.decode(response.body));
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      throw Exception('Failed to fetch user');
    }
  }
  Future<void> DeletePost(int id) async {
    try {
      isLoading.value = true;
      final response = await http.delete(
        Uri.parse('$DeletePostURL/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        print(json.decode(response.body));
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      throw Exception('Failed to fetch user');
    }
  }
}
