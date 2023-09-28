import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_main/Category.dart';
import 'package:memory_main/buttonNavBar.dart';

import 'package:memory_main/controller/visitor.dart';

import 'package:memory_main/visitor/Post_visitor.dart';

class Service {
  final String name_service;
  Service({required this.name_service});
}

class CategoryDetails {
  final int id_category;
  final String categoryService;
  CategoryDetails({
    required this.id_category,
    required this.categoryService,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const Posts({super.key});
  List<Service> service = [];
  List<CategoryDetails> categories = [
    CategoryDetails(id_category: 1, categoryService: "Farming "),
    CategoryDetails(id_category: 2, categoryService: "Carpentry"),
    CategoryDetails(id_category: 3, categoryService: "ART"),
    CategoryDetails(id_category: 4, categoryService: "Build"),
    CategoryDetails(id_category: 5, categoryService: "Hand Craft"),
    CategoryDetails(id_category: 6, categoryService: "Sawing"),
    CategoryDetails(id_category: 7, categoryService: "Paint"),
  ];

  final Visitor managePost = Get.put(Visitor());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEDFDA),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: const Text(
                          " Welcome to",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 26,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 10.0,
                                  offset: Offset(5.0, 5.0),
                                ),
                              ]),
                        ),
                      ),
                      Container(
                        child: const Text(
                          "  Job Offers World !",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              shadows: [
                                Shadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                  offset: Offset(7.0, 7.0),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 50,
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
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Container(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                child: const Text(
                                  "Categories:",
                                  overflow: TextOverflow.ellipsis,
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
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  // color: Color(0xffaadcb6),
                                ),
                                height: 50.0,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      buildCategory(categories[index]),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          // width: 5.0,
                                          ),
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
                      return managePost.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: managePost.posts.value.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: PostVisitor(
                                    posts: managePost.posts.value[index],
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
      /*bottomNavigationBar: Container(
        height: 40,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Color(0xFFBFFFC7),
              Color(0xFFf9e866),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              CupertinoIcons.home,
              color: Colors.black54,
            ),
            Icon(
              CupertinoIcons.home,
              color: Colors.black54,
            ),
            Icon(
              CupertinoIcons.person,
              color: Colors.black54,
            ),
          ],
        ),
      ),*/
      bottomNavigationBar: ButtonNavBar(),
    );
  }

  Widget buildCategory(CategoryDetails category) => Row(children: [
        Category(
          categoryService: '${category.categoryService}',
          colorText: const Color(0xff3e7e55),
          colorShadow: const Color(0xfffaee9e),
        ),
        const SizedBox(
          width: 10.0,
        )
      ]);
}
