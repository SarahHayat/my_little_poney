
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
}

enum Speciality {
  dressage,
  showJumping,
  endurance,
  complete,
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
  User? owner;
  DateTime createdAt;
  // maybe for after
  List<User> dpUsers;

  Horse(this.dpUsers,
      this.id,
      this.owner,
      {required this.name,
      required this.age,
      required this.picturePath,
      required this.dress,
      required this.race,
      required this.gender,
      required this.speciality,
      required this.createdAt,});
}
