import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/Party.dart';
import 'package:my_little_poney/models/User.dart';

class Mock {
  static User userManagerOwner = User(
    "id1",
    "profilePicture",
    20,
    "FFELink",
    "phoneNumber",
    UserRole.manager,
    [horse],
    DateTime.now(),
    Type.owner,
    userName: "Antony",
    password: "12345",
    email: "antony@gmail.com",
  );

  static User userManagerOwner2 = User(
    "id1",
    "profilePicture",
    20,
    "FFELink",
    "phoneNumber",
    UserRole.manager,
    [],
    DateTime.now(),
    Type.owner,
    userName: "Antony",
    password: "12345",
    email: "antony@gmail.com",
  );

  static User userRiderDp = User(
    "id2",
    "profilePicture",
    20,
    "FFELink",
    "phoneNumber",
    UserRole.rider,
    [horse],
    DateTime.now(),
    Type.dp,
    userName: "Jojo",
    password: "12345",
    email: "antony@gmail.com",
  );

  static User userRiderDp2 = User(
    "id2",
    "profilePicture",
    20,
    "FFELink",
    "phoneNumber",
    UserRole.rider,
    [],
    DateTime.now(),
    Type.dp,
    userName: "Jojo",
    password: "12345",
    email: "antony@gmail.com",
  );

  static Horse horse = Horse(
    [],
    "id1",
    name: "Etoile d'argent",
    age: 2,
    picturePath: "picturePath",
    dress: "dress",
    race: HorseRace.appaloosa,
    gender: Gender.other,
    speciality: Speciality.endurance,
    owner: userManagerOwner2,
    createdAt: DateTime.now(),
  );

  static Horse horse2 = Horse(
    [],
    "id2",
    name: "Pegase",
    age: 5,
    picturePath: "picturePath",
    dress: "brown",
    race: HorseRace.pureSang,
    gender: Gender.male,
    speciality: Speciality.showJumping,
    owner: userManagerOwner2,
    createdAt: DateTime.now(),
  );

  static Party party = Party(
    "id1",
    "picturePath",
    [AttendeeParty("Des chips !", user: userManagerOwner)],
    user: userRiderDp,
    theme: Theme.happyHour,
    createdAt: DateTime.now(),
  );

  static Lesson lesson = Lesson("id1", [],
      name: "name",
      user: userManagerOwner,
      ground: Ground.carousel,
      lessonDateTime: DateTime.now(),
      createdAt: DateTime.now(),
      duration: 30,
      discipline: Discipline.endurance);

  static Contest contest = Contest(
    "id1",
    [],
    user: userRiderDp,
    name: "name",
    address: "address",
    picturePath: "picturePath",
    contestDateTime: DateTime.now(),
    createdAt: DateTime.now(),
  );
}
