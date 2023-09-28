// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:memory_main/constants/constants.dart';
import 'package:memory_main/models/PostModel.dart';
import 'package:memory_main/pages/Posts.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ManagePost extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }
  
   

  Future<void> getAllPosts() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(getPostsURL),
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

  Future<void> createPosts(
      String title, String description, List<String> imagePost) async {
    try {
      isLoading.value = true;

      final request = http.MultipartRequest('POST', Uri.parse(createPostURL));
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${box.read('token')}';

      request.fields['title'] = title;
      request.fields['description'] = description;

      for (var imagePath in imagePost) {
        File imageFile = File(imagePath);
        String fileName = path.basename(imageFile.path);

        request.files.add(await http.MultipartFile.fromPath(
          'images_post[]',
          imageFile.path,
          filename: fileName,
        ));
      }

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        isLoading.value = false;
        print(json.decode(responseString));

        Get.offAll(const Posts());
      } else {
        isLoading.value = false;
        print(json.decode(responseString));
      }
    } catch (e) {
      isLoading.value = false;
      print('Failed to create post: $e');
    }
  }

  Future<String> downloadImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/${path.basename(imageUrl)}';

    await File(imagePath).writeAsBytes(bytes);

    return imagePath;
  }

  Future<void> updatePost(int idPost, String title, String description,
      List<String> imagePost) async {
    try {
      isLoading.value = true;

      final request =
          http.MultipartRequest('POST', Uri.parse('$updatePostURL/$idPost'));
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${box.read('token')}';

      request.fields['title'] = title;
      request.fields['description'] = description;

      for (var imagePath in imagePost) {
        if (imagePath.startsWith('http')||imagePath.startsWith('https') ) {
          // Download the image if necessary
          imagePath = await downloadImage(imagePath);
        }

        File imageFile = File(imagePath);
        String fileName = path.basename(imageFile.path);

        request.files.add(await http.MultipartFile.fromPath(
          'images_post[]',
          imageFile.path,
          filename: fileName,
        ));
      }

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        isLoading.value = false;
        print(json.decode(responseString));

        // Assuming the response contains the updated post data
        //  PostModel updatedPost = postFromJson(responseString);
        // Handle the updated post as needed

        Get.offAll(const Posts());
      } else {
        isLoading.value = false;
        final errorMessage = json.decode(responseString)['message'];
        print(errorMessage);
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Message'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(errorMessage),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      isLoading.value = false;
      print('Failed to update post: $e');
    }
  }

  Future<void> deletePost(int idPost) async {
    try {
      isLoading.value = true;
      final response = await http.delete(
        Uri.parse('$deletePostURL/$idPost'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        print(json.decode(response.body));
        Get.offAll(const Posts());
      } else {
        isLoading.value = false;
        final errorMessage = json.decode(response.body)['message'];
        print(errorMessage);
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Message'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(errorMessage),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      isLoading.value = false;

      print(e.toString());
    }
  }

  Future<User> getAnotherUserA(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$getAnotherUser/$id'),
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
}
