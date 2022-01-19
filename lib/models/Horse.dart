import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'Horse.g.dart';

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

@JsonSerializable()
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

  Horse(
      this.id,
      this.owner,
      {
        this.dpUsers = const [],
        required this.name,
        required this.age,
        required this.picturePath,
        required this.dress,
        required this.race,
        required this.gender,
        required this.speciality,
        required this.createdAt,
      });

  factory Horse.fromJson(Map<String, Object?> json) => _$HorseFromJson(json);
  Map<String, Object?> toJson() => _$HorseToJson(this);
}

@Collection<Horse>('horses')
final horsesRef = HorseCollectionReference();