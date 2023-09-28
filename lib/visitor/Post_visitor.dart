import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:memory_main/controller/post_service.dart';

import 'package:memory_main/models/PostModel.dart';

import 'package:memory_main/visitor/details_visitor.dart';

class PostVisitor extends StatefulWidget {
  const PostVisitor({Key? key, required this.posts}) : super(key: key);

  final PostModel posts;

  @override
  State<PostVisitor> createState() => _PostVisitorState();
}

class _PostVisitorState extends State<PostVisitor> {
  double? fontSize;
  Color? colorText, colorback;
  VoidCallback? onTap;
  ManagePost managePost = ManagePost();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 14.0,
                  offset: Offset(4.0, 4.0),
                ),
              ],
              color: Colors.white24,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          CircleAvatar(
                            radius: 20.0,
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
                              child: CircleAvatar(
                                radius: 18.0,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(widget.posts.user.profileImg),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.posts.user.username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color(0xffb66200),
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Color(0xFFf9e866),
                              blurRadius: 15.0,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.posts.images.map((Images image) {
                        return Container(
                          width: 150,
                          height:
                              150, // adjust the width as per your requirement
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Image.network(
                            image.imagesPost,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  if (colorback != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 200,
                        width: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10.0),
                  Text(
                    widget.posts.title,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: colorText,
                      fontWeight: FontWeight.w800,
                      shadows: const [
                        Shadow(
                          color: Colors.yellowAccent,
                          blurRadius: 15.0,
                          offset: Offset(6.0, 6.0),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5.0),
                  TextButton(
                    onPressed: () {
                      Get.offAll(DetailsVisitor(postModel: widget.posts));
                    },
                    child: Text(
                      'Details',
                      style: const TextStyle(color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
