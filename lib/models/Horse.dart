import 'package:cloud_firestore/cloud_firestore.dart';

import 'User.dart';


enum HorseRace {
  arabe,
  frison,
  pureSang,
  shire,
  quarterHorse,
  appaloosa,
  mustang,
  paintHorse,
  cobGypsy,
  kwpn,
  percheron,
  breton,
}

enum Gender {
  male,
  female,
  other,
}

enum Speciality {
  dressage,
  showJumping,
  endurance,
  complete,
}

class Movie {
  Movie({required this.title, required this.genre});


  Movie.fromJson(Map<String, Object?> json)
      : this(
    title: json['title']! as String,
    genre: json['genre']! as String,
  );

  final String title;
  final String genre;

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'genre': genre,
    };
  }
}


class Horse {
  String? id;
  String name;
  int age;
  String picturePath;
  String dress;
  HorseRace race;
  Gender gender;
  Speciality speciality;
  DocumentReference? owner;
  DateTime createdAt;
  // maybe for after
  // List<User> dpUsers;

  Horse(

      {
        this.id,
        this.owner,
        // this.dpUsers = const [],
        required this.name,
        required this.age,
        required this.picturePath,
        required this.dress,
        required this.race,
        required this.gender,
        required this.speciality,
        required this.createdAt,
      });

  Horse.fromJson(Map<String, Object?> json) : this(
    id: json['id']! as String,
    owner: json['owner']! as DocumentReference,
    name: json['name']! as String,
    age: json['age']! as int,
    picturePath: json['picturePath']! as String,
    dress: json['dress']! as String,
    race: json['race']! as HorseRace,
    gender: json['gender']! as Gender,
    speciality: json['speciality']! as Speciality,
    createdAt: json['createdAt']! as DateTime,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'owner': owner,
      'name': name,
      'age': age,
      'picturePath': picturePath,
      'dress': dress,
      'race': race,
      'gender': gender,
      'speciality': speciality,
      'createdAt': createdAt,
    };
  }

}