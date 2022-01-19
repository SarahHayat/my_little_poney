import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<dynamic>? horsesIds;
  Timestamp? createdAt;

  User(
     {
       this.id,
       this.profilePicture,
       this.age,
       this.ffeLink,
       this.phoneNumber,
       this.role,
       this.horsesIds,
       this.createdAt,
       this.type,
       required this.userName,
       required this.password,
       required this.email,
  });

  User.fromJson(Map<String, Object?> json) : this(
    id: json['id'] != null ? json['id']! as String : "",
    profilePicture: json['profilePicture']!= null ? json['profilePicture']! as String : "",
    age: json['age']!= null ? json['age']! as int : 0,
    ffeLink: json['ffeLink'] != null ? json['ffeLink']! as String : "",
    phoneNumber: json['phoneNumber']!= null ? json['phoneNumber']! as String : "",
    role: json['role']!= null ? json['role']! as String : "",
    horsesIds: json['horses']! as List<dynamic>,
    createdAt: json['createdAt']! as Timestamp,
    type: json['type']! as String,
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
      'horses': horsesIds,
      'createdAt': createdAt,
      'type': type,
      'userName': userName,
      'password': password,
      'email': email,
    };
  }

  static CollectionReference<User> ref = FirebaseFirestore
      .instance.collection('users')
      .withConverter<User>(
    fromFirestore: (snapshot, _) =>
        User.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );

  factory User.empty() => User(userName: "", password: "", email: "");

  Future<List<Horse>> getHorses() async {
    Future<List<Horse>> futureHorses = Future(Horse.emptyList);

    // return horsesIds?.(e) => Horse.ref.doc(e.id).get().then((snapshot) => snapshot.data()!)
    // return ownerId?.id != null ? await User.ref.doc(ownerId?.id).get().then((snapshot) => snapshot.data()!) : await futureUser;
  }
}


