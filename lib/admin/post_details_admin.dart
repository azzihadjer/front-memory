import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_main/admin/admin_page.dart';
import 'package:memory_main/admin/profile_user.dart';
import 'package:memory_main/controller/user_service.dart';
import 'package:memory_main/models/PostModel.dart';
import 'package:memory_main/models/Post_to_User.dart';
import 'package:memory_main/pages/profile.dart';

class PostDetailsAdmin extends StatefulWidget {
  const PostDetailsAdmin({Key? key, required this.postModel}) : super(key: key);

  final PostModel postModel;

  @override
  State<PostDetailsAdmin> createState() => _PostDetailsAdminState();
}

class _PostDetailsAdminState extends State<PostDetailsAdmin> {
  Authentification p = Authentification();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f1e9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(const AdminHome());
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xff578f53),
                      ),
                    ),
                  ),
                  const Text(
                    "Details",
                    style: TextStyle(
                        color: Color(0xff578f53),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Color(0xff578f53),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          widget.postModel.images.length,
                          (index) => Container(
                            margin: const EdgeInsets.all(10),
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.postModel.images[index].imagesPost,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.postModel.title,
                      style: const TextStyle(
                        color: Color(0xff578f53),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color(0xFF387A5C),
                            blurRadius: 10.0,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 110,
                        width: 450,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 217, 214, 207),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Description :",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pacifico',
                                  )),
                              const SizedBox(
                                height: 7,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.postModel.description,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pacifico',
                                  ),
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
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          height: 70,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xffaadcb6),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Contact us",
                      style: TextStyle(
                        color: Color(0xfff4f1e9),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            CircleAvatar(
                              radius: 16.0,
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
                                onTap: () async {
                                  final currentUserID = await p.getUserId();

                                  if (widget.postModel.userId ==
                                      currentUserID) {
                                    Get.to(
                                        const ProfileUser()); // Navigate to the current user's profile
                                  } else {
                                    Get.to(ProfileAnotherUserAdmin(
                                        user: convertUserToUserModel(
                                            widget.postModel.user)));
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 14.0,
                                  backgroundColor: Colors.amber,
                                  backgroundImage: NetworkImage(widget
                                          .postModel.user.profileImg ??
                                      'https://static.wikia.nocookie.net/naruto/images/7/7d/Sasuke%27s_Rinnegan.png/revision/latest?cb=20160909022555'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                          onPressed: () async {
                            final currentUserID = await p.getUserId();

                            if (widget.postModel.userId == currentUserID) {
                              Get.to(
                                  const ProfileUser()); // Navigate to the current user's profile
                            } else {
                              Get.to(ProfileAnotherUserAdmin(
                                  user: convertUserToUserModel(
                                      widget.postModel.user)));
                            }
                          },
                          child: Text(
                            widget.postModel.user.username,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF387A5C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
