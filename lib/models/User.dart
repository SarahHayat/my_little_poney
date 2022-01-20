import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/string_extension.dart';

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

enum UserType {
  dp,
  owner,
}
extension TypeExtension on UserType {
  Icon getRoleIcon() {
    switch (this) {
      case UserType.dp:
        return Icon(Icons.paid_outlined);
      case UserType.owner:
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
  String? id;
  String userName;
  String password;
  String email;
  String? profilePicture;
  int? age;
  String? ffeLink;
  String? phoneNumber;
  String? role;
  String? type;
  List<dynamic>? horses;
  DateTime? createdAt;

  User({
    this.id,
    this.profilePicture,
    this.age,
    this.ffeLink,
    this.phoneNumber,
    this.role,
    this.horses,
    this.createdAt,
    this.type,
    required this.userName,
    required this.password,
    required this.email,
  });

  bool isManager(){
    return this.role == UserRole.manager.toShortString();
  }
  bool isOwner(){
    return this.type == UserType.owner.toShortString();
  }




  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] != null ? json['id']! as String : "",
      profilePicture: json['profilePicture'] != null
          ? json['profilePicture']! as String
          : "",
      age: json['age'] != null ? json['age']! as int : 0,
      ffeLink: json['ffeLink'] != null ? json['ffeLink']! as String : "",
      phoneNumber:
          json['phoneNumber'] != null ? json['phoneNumber']! as String : "",
      role: json['role'] != null ? json['role']! as String : "",
      horses: json['horses']! as List<dynamic>,
      createdAt: DateTime.parse(json['createdAt']! as String),
      type: json['type'] != null ? json['type'] as String : '',
      userName: json['userName']! as String,
      password: json['password']! as String,
      email: json['email']! as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'profilePicture': profilePicture,
      'age': age,
      'ffeLink': ffeLink,
      'phoneNumber': phoneNumber,
      'role': role,
      'horses': horses,
      'createdAt': createdAt,
      'type': type,
      'userName': userName,
      'password': password,
      'email': email,
    };
  }
}
