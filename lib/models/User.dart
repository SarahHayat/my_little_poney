import 'package:my_little_poney/models/Horse.dart';

enum UserRole {
  rider,
  manager,
}

enum Type {
  dp,
  owner,
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
}
