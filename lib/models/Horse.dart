

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
  String race;
  String gender;
  String speciality;
  DocumentReference? ownerId;
  Timestamp createdAt;
  // maybe for after
  // List<User> dpUsers;

  Horse(

      {
        this.id,
        this.ownerId,
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
    id: json['id'] != null ? json['id']! as String : "" ,
    ownerId: json['owner']! as DocumentReference,
    name: json['name']! as String,
    age: json['age']! as int,
    picturePath: json['picturePath']! as String,
    dress: json['dress']! as String,
    race: json['race']! as String,
    gender: json['gender']! as String,
    speciality: json['speciality']! as String,
    createdAt: json['createdAt']! as Timestamp,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'owner': ownerId,
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

  static CollectionReference<Horse> ref = FirebaseFirestore
      .instance.collection('horses')
      .withConverter<Horse>(
    fromFirestore: (snapshot, _) =>
        Horse.fromJson(snapshot.data()!),
    toFirestore: (horse, _) => horse.toJson(),
  );

  factory Horse.empty() => Horse(
      name: "",
      age: 0,
      picturePath: "",
      dress: "",
      race: HorseRace.mustang.name,
      gender: Gender.other.name,
      speciality: Speciality.endurance.name,
      createdAt: Timestamp.now()
  );

  static List<Horse> emptyList() {
    return [Horse(
        name: "",
        age: 0,
        picturePath: "",
        dress: "",
        race: HorseRace.mustang.name,
        gender: Gender.other.name,
        speciality: Speciality.endurance.name,
        createdAt: Timestamp.now()
    )];
  }

  Future<User> getOwner() async {
    Future<User> futureUser = Future(User.empty);
    return ownerId?.id != null ? await User.ref.doc(ownerId?.id).get().then((snapshot) => snapshot.data()!) : await futureUser;
  }
}