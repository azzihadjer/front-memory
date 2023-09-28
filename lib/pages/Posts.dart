import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_main/Category.dart';
import 'package:memory_main/controller/post_service.dart';
import 'package:memory_main/controller/user_service.dart';

import 'package:memory_main/models/User.dart';
import 'package:memory_main/pages/Post.dart';

import 'package:memory_main/pages/profile.dart';
import 'package:memory_main/widgets/additionPage.dart';

class Service {
  final String nameService;

  Service({required this.nameService});
}

class CategoryDetails {
  final int categoryId;
  final String categoryService;

  CategoryDetails({
    required this.categoryId,
    required this.categoryService,
  });
}

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<Service> services = [];

  List<CategoryDetails> categories = [
    CategoryDetails(categoryId: 1, categoryService: "Farming"),
    CategoryDetails(categoryId: 2, categoryService: "Carpentry"),
    CategoryDetails(categoryId: 3, categoryService: "ART"),
    CategoryDetails(categoryId: 4, categoryService: "Build"),
    CategoryDetails(categoryId: 5, categoryService: "Hand Craft"),
    CategoryDetails(categoryId: 6, categoryService: "Sawing"),
    CategoryDetails(categoryId: 7, categoryService: "Paint"),
  ];

  final Authentification auth = Authentification();
  UserModel? currentUser;
  final ManagePost managePostController = Get.put(ManagePost());
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
      backgroundColor: const Color(0xFFDEDFDA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CircleAvatar(
                          radius: 24.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF7DBD72),
                                  Color(0xFFF1B602),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.offAll(const ProfileUser());
                            },
                            child: CircleAvatar(
                              radius: 22.0,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(currentUser
                                      ?.profileImg ??
                                  'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                            ),
                          ),
                        ),
                      ], //NetworkImage(widget.posts.user.profileImg),
                    ),
                    const SizedBox(
                      width: 110,
                    ),
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
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xff578f53)),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.offAll(AddPost());
                            },
                            icon: Icon(
                              Icons.add,
                              color: Color(0xff578f53),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
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
                          child: const Icon(
                            Icons.search,
                            color: Color(0xff578f53),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
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
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xff578f53)),
                          ),
                          child: IconButton(
                            onPressed: () {
                              auth.logout();
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Color(0xff578f53),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xffaadcb6),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  child: const Text(
                                    "Categories:",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xff578f53),
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Color(0xfffaee9e),
                                          blurRadius: 15.0,
                                          offset: Offset(7.0, 7.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  height: 60.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        buildCategory(categories[index]),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(),
                                    itemCount: categories.length,
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Obx(() {
                        return managePostController.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    managePostController.posts.value.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Post(
                                      posts: managePostController
                                          .posts.value[index],
                                    ),
                                  );
                                },
                              );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategory(CategoryDetails category) => Row(
        children: [
          Category(
            categoryService: '${category.categoryService}',
            colorText: const Color(0xff3e7e55),
            colorShadow: const Color(0xfffaee9e),
          ),
          const SizedBox(
            width: 10.0,
          )
        ],
      );
}
