import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      displayName: displayName,
    );
  }
}
