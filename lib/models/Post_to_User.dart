

import 'package:memory_main/models/PostModel.dart';
import 'package:memory_main/models/User.dart';

UserModel convertUserToUserModel(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      phoneNumber: user.phoneNumber,
      wilaya: user.wilaya,
      profileImg: user.profileImg,
      typeJob: user.typeJob,
      nameService: user.nameService,
      rating: user.rating,
      bannedAt: user.bannedAt,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }