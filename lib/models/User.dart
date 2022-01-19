import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/string_extension.dart';
import 'package:my_little_poney/models/Horse.dart';

enum UserRole {
  rider,
  manager,
}
extension UserRoleExtension on UserRole {
  Icon getRoleIcon() {
    switch (this) {
      case UserRole.manager:
        return Icon(Icons.supervisor_account_rounded);
      case UserRole.rider:
        return Icon(Icons.account_circle_outlined);
      default:
        return Icon(Icons.account_circle_outlined);
    }
  }
  String toShortString() {
    return this.toString().enumValueToNormalCase();
  }
}

enum Type {
  dp,
  owner,
}
extension TypeExtension on Type {
  Icon getRoleIcon() {
    switch (this) {
      case Type.dp:
        return Icon(Icons.paid_outlined);
      case Type.owner:
        return Icon(Icons.credit_card);
      default:
        return Icon(Icons.attach_money);
    }
  }
  String toShortString() {
    return this.toString().enumValueToNormalCase();
  }
}

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

  bool isManager(){
    return this.role == UserRole.manager;
  }
  bool isOwner(){
    return this.type == Type.owner;
  }
}
