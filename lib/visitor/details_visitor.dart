import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:memory_main/models/PostModel.dart';

import 'package:memory_main/visitor/home_page.dart';

class DetailsVisitor extends StatefulWidget {
  const DetailsVisitor({Key? key, required this.postModel}) : super(key: key);

  final PostModel postModel;

  @override
  State<DetailsVisitor> createState() => _DetailsVisitorState();
}

class _DetailsVisitorState extends State<DetailsVisitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f1e9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(const HomePage());
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Color(0xff578f53),
                      ),
                    ),
                  ),
                  Text(
                    "Details",
                    style: TextStyle(
                        color: Color(0xff578f53),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xff578f53),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
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
                            margin: EdgeInsets.all(10),
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
                    SizedBox(height: 10),
                    Text(
                      widget.postModel.title,
                      style: TextStyle(
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
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 120,
                        width: 450,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 217, 214, 207),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Description :",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pacifico',
                                  )),
                              SizedBox(
                                height: 7,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.postModel.description,
                                  style: TextStyle(
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
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xffaadcb6),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
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
                                decoration: BoxDecoration(
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
                        SizedBox(width: 5),
                        Text(
                          widget.postModel.user.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF387A5C),
                            fontWeight: FontWeight.bold,
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
