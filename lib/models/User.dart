import 'package:cloud_firestore/cloud_firestore.dart';

import 'Horse.dart';


enum UserRole {
  rider,
  manager,
}

enum Type {
  dp,
  owner,
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
  UserRole? role;
  Type? type;
  List<DocumentReference>? horses;
  DateTime? createdAt;

  User(
     {
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

  User.fromJson(Map<String, Object?> json) : this(
    id: json['id']! as String,
    profilePicture: json['profilePicture']! as String,
    age: json['age']! as int,
    ffeLink: json['ffeLink']! as String,
    phoneNumber: json['phoneNumber']! as String,
    role: json['role']! as UserRole,
    horses: json['horses']! as List<DocumentReference>,
    createdAt: json['createdAt']! as DateTime,
    type: json['type']! as Type,
    userName: json['userName']! as String,
    password: json['password']! as String,
    email: json['email']! as String,
  );

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


