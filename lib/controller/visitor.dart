import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memory_main/constants/constants.dart';
import 'package:memory_main/models/PostModel.dart';
import 'package:http/http.dart' as http;

class Visitor extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
    @override
  void onInit() {
    getAllPostsAsVisitor();
    super.onInit();
  }

  Future<void> getAllPostsAsVisitor() async {
      try {
      posts.value.clear();
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(getPostURL),
        headers: {
          'Accept': 'application/json',
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
}
