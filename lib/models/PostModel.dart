
// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';


PostModel postFromJson(String str) => PostModel.fromJson(json.decode(str));

String postToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
    int id;
    int userId;
    String title;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    User user;
    List<Images> images;

    PostModel({
        required this.id,
        required this.userId,
        required this.title,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
        required this.images,
    });

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
      );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class Images {
    int id;
    int userId;
    int postId;
    String imagesPost;
    DateTime createdAt;
    DateTime updatedAt;

    Images({
        required this.id,
        required this.userId,
        required this.postId,
        required this.imagesPost,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        imagesPost: json["images_post"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post_id": postId,
        "images_post": imagesPost,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class User {
    int id;
    String username;
    String email;
    String phoneNumber;
    String wilaya;
    dynamic profileImg;
    String typeJob;
    String nameService;
    dynamic rating;
    dynamic bannedAt;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.username,
        required this.email,
        required this.phoneNumber,
        required this.wilaya,
        this.profileImg,
        required this.typeJob,
        required this.nameService,
        this.rating,
        this.bannedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        wilaya: json["wilaya"],
        profileImg: json["profile_img"],
        typeJob: json["type_job"],
        nameService: json["name_service"],
        rating: json["rating"],
        bannedAt: json["banned_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
  

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "wilaya": wilaya,
        "profile_img": profileImg,
        "type_job": typeJob,
        "name_service": nameService,
        "rating": rating,
        "banned_at": bannedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
