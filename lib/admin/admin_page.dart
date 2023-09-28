import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_main/admin/post_details_admin.dart';
import 'package:memory_main/admin/profile_user.dart';

import 'package:memory_main/controller/admin_service.dart';
import 'package:memory_main/models/PostModel.dart';
import 'package:memory_main/models/User.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _currentIndex = 0;
  final Admin admin = Get.put(Admin());
  final List<UserModel> _users = [];
  final List<PostModel> _posts = [];
  bool isLoadingPosts = false;
  @override
  void initState() {
    super.initState();
    getAllUsers();
    getAllPost();
  }

  Future<void> getAllUsers() async {
    try {
      await admin.getAlluser();
      // ignore: unnecessary_null_comparison
      if (admin.users.value != null) {
        setState(() {
          _users.clear();
          _users.addAll(admin.users.value);
        });
      } else {
        // Handle the case when the list of users is null
        print('List of users is null');
      }
    } catch (e) {
      // Handle any other errors that occur during the API call
      print('Error fetching users: $e');
    }
  }

  Future<void> getAllPost() async {
    try {
      setState(() {
        isLoadingPosts = true;
      });

      await admin.getAllPosts(); // Call the function from Admin controller

      // Update the _posts list with the fetched posts
      setState(() {
        _posts.clear();
        _posts.addAll(admin.posts.value);
        isLoadingPosts = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoadingPosts = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'All Posts' : 'All Users'),
        actions: [
          IconButton(
            onPressed: () {
              admin.logout();
            },
            icon: const Icon(
              Icons.logout,
              size: 30.0,
              color: Color(0xFFF4EBD2),
            ),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      return _buildPosts();
    } else {
      return _buildUsers();
    }
  }

  Widget _buildPosts() {
    if (isLoadingPosts) {
      return const Center(child: CircularProgressIndicator());
    } else if (admin.posts.value.isEmpty) {
      return const Center(child: Text('No posts available'));
    } else {
      _posts.clear(); // Clear the existing posts
      _posts.addAll(admin.posts.value); // Add the fetched posts to _posts list
      return ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(post.user.profileImg),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.user.username,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    Get.offAll(PostDetailsAdmin(
                      postModel: post,
                    ));
                  },
                  child: Text(post.title),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _deletePost(post.id);
                  },
                ),
              ),
              const Divider(),
            ],
          );
        },
      );
    }
  }

  Widget _buildUsers() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return GestureDetector(
            onTap: () {
              // Navigate to another page with user details
              Get.offAll(ProfileAnotherUserAdmin(user: user));
            },
            child: ListTile(
              title: Text(user.username),
              subtitle: Text(
                  'Job Type: ${user.typeJob} | Service: ${user.nameService} | Ban: ${user.bannedAt}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.block,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _banUser(user.id, 'Ban comment');
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.restart_alt_rounded,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      _unbanUser(user.id);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _deleteUser(user.id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _banUser(int userId, String comment) {
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ban User'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(
              labelText: 'Comment',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                String comment = commentController.text;
                _performBanUser(userId, comment);
              },
              child: const Text('Ban'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _performBanUser(int userId, String comment) {
    admin.banUser(userId, comment).then((_) {
      getAllUsers();
    }).catchError((error) {
      print('Failed to ban user: $error');
    });
  }

  void _unbanUser(int userId) {
    // Call the unbanUser function from the Admin controller
    admin.unbanUser(userId).then((_) {
      // Refresh the user list after unbanning the user
      getAllUsers();
    }).catchError((error) {
      print('Failed to unban user: $error');
    });
  }

  void _deleteUser(int userId) {
    // Call the DeleteUser function from the Admin controller
    admin.DeleteUser(userId).then((_) {
      // Refresh the user list after deleting the user
      getAllUsers();
    }).catchError((error) {
      print('Failed to delete user: $error');
    });
  }

  void _deletePost(int postId) {
    admin.DeletePost(postId).then((_) {
      getAllPost();
    }).catchError((error) {
      print('Failed to delete post: $error');
    });
  }
}
