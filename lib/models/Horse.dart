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

class Horse {
  String? id;
  String name;
  int age;
  String picturePath;
  String dress;
  String race;
  String gender;
  String speciality;
  String? owner;
  DateTime createdAt;

  // maybe for after
  List<dynamic>? dpUsers;

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
      dpUsers: json['dpUsers'] != null ? json['dpUsers']! as List<dynamic>? : [],
      owner: json['owner'] != null ? json['owner']! as String? : null,
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
      'dpUsers': dpUsers,
      'owner': owner,
      'picturePath': picturePath,
      'age': age,
      'dress': dress,
      'createdAt': createdAt.toString(),
      'name': name,
      'race': race,
      'speciality': speciality,
      'gender': gender,
    };
  }
}
