import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/models/Horse.dart';

Horse horse = Horse(
  name: "Etoile d'argent",
  age: 2,
  picturePath: "picturePath",
  dress: "dress",
  race: HorseRace.appaloosa.name,
  gender: Gender.other.name,
  speciality: Speciality.endurance.name,
  owner: null,
  createdAt: DateTime.now(),
);

late User userRiderDp = User(
  id: 'monId1',
  profilePicture: "profilePicture",
  age: 20,
  ffeLink: "FFELink",
  phoneNumber: "phoneNumber",
  role: UserRole.rider.name,
  horses: [horse],
  createdAt: DateTime.now(),
  type: UserType.dp.name,
  userName: "Jojo",
  password: "12345",
  email: "antony@gmail.com",
);

late User monUser = User(
  id: "id2",
  profilePicture: "profilePicture",
  age: 20,
  ffeLink: "FFELink",
  phoneNumber: "phoneNumber",
  role: UserRole.rider.name,
  horses: [horse],
  createdAt: DateTime.now(),
  type: UserType.dp.name,
  userName: "Brian",
  password: "12345",
  email: "b.lecarpentier@edu.itescia.fr",
);

late Contest contest = Contest(
  user: userRiderDp.id.toString(),
  attendeesContest: [],
  name: "Concours 1",
  address: "address",
  picturePath: "picturePath",
  contestDateTime: DateTime.now(),
  createdAt: DateTime.now(),
);
