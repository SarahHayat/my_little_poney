import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/models/Horse.dart';

Horse horse = Horse(
  [],
  "id1",
  name: "Etoile d'argent",
  age: 2,
  picturePath: "picturePath",
  dress: "dress",
  race: HorseRace.appaloosa,
  gender: Gender.other,
  speciality: Speciality.endurance,
  owner: null,
  createdAt: DateTime.now(),
);

late User userRiderDp = User(
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

late User monUser = User(
  "id2",
  "profilePicture",
  20,
  "FFELink",
  "phoneNumber",
  UserRole.rider,
  [horse],
  DateTime.now(),
  Type.dp,
  userName: "Brian",
  password: "12345",
  email: "b.lecarpentier@edu.itescia.fr",
);

late Contest contest = Contest(
  "id1",
  [],
  user: userRiderDp,
  name: "Concours 1",
  address: "address",
  picturePath: "picturePath",
  contestDateTime: DateTime.now(),
  createdAt: DateTime.now(),
);
