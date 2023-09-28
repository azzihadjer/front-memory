// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int id;
    String username;
    String email;
    String phoneNumber;
    String wilaya;
    String profileImg;
    String typeJob;
    String nameService;
    dynamic rating;
    dynamic bannedAt;
    DateTime createdAt;
    DateTime updatedAt;

    UserModel({
        required this.id,
        required this.username,
        required this.email,
        required this.phoneNumber,
        required this.wilaya,
        required this.profileImg,
        required this.typeJob,
        required this.nameService,
        this.rating,
        this.bannedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
