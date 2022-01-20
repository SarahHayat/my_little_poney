import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/string_extension.dart';

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
extension HorseRaceExtension on HorseRace {
  String toShortString() {
    return this.toString().enumValueToNormalCase();
  }
}

enum Gender {
  male,
  female,
  other,
}
extension GenderExtension on Gender {
  Icon getGenderIcon() {
    switch (this) {
      case Gender.male:
        return Icon(Icons.male);
      case Gender.female:
        return Icon(Icons.female);
      case Gender.other:
        return Icon(Icons.transgender_outlined);
      default:
        return Icon(Icons.male);
    }
  }
  String toShortString() {
    return this.toString().enumValueToNormalCase();
  }
}

enum Speciality {
  dressage,
  showJumping,
  endurance,
  complete,
}
extension SpecialityExtension on Speciality {
  String toShortString() {
    return this.toString().enumValueToNormalCase();
  }
}

class Horse {
  String? id;
  String name;
  int age;
  String picturePath;
  String dress;
  String race;
  String gender;
  String speciality;
  User? owner;
  DateTime createdAt;

  // maybe for after
  List<String>? dpUsers;

  Horse({
    this.id,
    this.dpUsers,
    this.owner,
    required this.name,
    required this.age,
    required this.picturePath,
    required this.dress,
    required this.race,
    required this.gender,
    required this.speciality,
    required this.createdAt,
  });

  factory Horse.fromJson(Map<String, dynamic> json) {
    return Horse(
      id: json['_id'] != null ? json['_id']! as String : "",
      dpUsers: json['dpUsers'] != null ? List<String>.from(json['dpUsers']) : [],
      owner: null,// @todo : user should be string (id) or a complete user.  -> json['owner'] != null ? json['owner']! as User? : null,
      picturePath: json['picturePath'] != null ? json['picturePath']! as String : "",
      age: json['age'] as int,
      dress: json['dress'] as String,
      createdAt: DateTime.parse(json['createdAt']! as String),
      name: json['name'] as String,
      race: json['race'] as String,
      speciality: json['speciality'] as String,
      gender: json['gender'] as String
    );
  }

  Map<String, Object?> toJson() {
    return {
      '_id': id,
      'dpUsers': dpUsers.toString(),
      'owner': "61e886829e6435822db10be7",//@todo : replace with real [owner],
      'picturePath': picturePath,
      'age': age.toString(),
      'dress': dress,
      'createdAt': createdAt.toString(),
      'name': name,
      'race': race,
      'speciality': speciality,
      'gender': gender,
    };
  }
}
