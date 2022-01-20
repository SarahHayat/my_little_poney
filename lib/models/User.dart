import 'package:my_little_poney/models/Horse.dart';

enum UserRole {
  rider,
  manager,
}

enum UserType {
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] != null ? json['_id']! as String : "",
      profilePicture: json['profilePicture'] != null
          ? json['profilePicture']! as String
          : "",
      age: json['age'] != null ? json['age']! as int : 0,
      ffeLink: json['FFELink'] != null ? json['FFELink']! as String : "",
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
      '_id': id,
      'profilePicture': profilePicture,
      'age': age,
      'FFELink': ffeLink,
      'phoneNumber': phoneNumber,
      'role': role,
      'horses': horses,
      'createdAt': createdAt.toString(),
      'type': type,
      'userName': userName,
      'password': password,
      'email': email,
    };
  }
}
