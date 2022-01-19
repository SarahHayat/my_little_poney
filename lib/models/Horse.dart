
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
  String id;
  String name;
  int age;
  String picturePath;
  String dress;
  HorseRace race;
  Gender gender;
  Speciality speciality;
  User owner;
  DateTime createdAt;
  // maybe for after
  List<User> dpUsers;

  Horse(this.dpUsers,
      this.id,
      {required this.name,
      required this.age,
      required this.picturePath,
      required this.dress,
      required this.race,
      required this.gender,
      required this.speciality,
      required this.owner,
      required this.createdAt,});
}
