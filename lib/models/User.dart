import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Horse.dart';

part 'User.g.dart';

enum UserRole {
  rider,
  manager,
}

enum Type {
  dp,
  owner,
}

@JsonSerializable()
class User {
  String id;
  String userName;
  String password;
  String email;
  String profilePicture;
  int age;
  String FFELink;
  String phoneNumber;
  UserRole role;
  Type type;
  List<Horse> horses;
  DateTime createdAt;

  User(
    this.id,
    this.profilePicture,
    this.age,
    this.FFELink,
    this.phoneNumber,
    this.role,
    this.horses,
    this.createdAt,
    this.type, {
    required this.userName,
    required this.password,
    required this.email,
  });

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
  Map<String, Object?> toJson() => _$UserToJson(this);
}

@Collection<User>('users')
final usersRef = UserCollectionReference();
