import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/Party.dart';
import 'package:my_little_poney/models/User.dart';

class Mock {
  static User userManagerOwner = User(
    id:"id1",
    profilePicture: "profilePicture",
    age:20,
    ffeLink: "FFELink",
    phoneNumber: "phoneNumber",
    role:UserRole.manager.toShortString(),
    horses:[],
    createdAt:DateTime.now(),
    type:UserType.owner.toString(),
      userName: "Jo",
    password: "12345",
    email: "jo@gmail.com",
  );

  static User userManagerOwner2 = User(
    id:"id2",
    profilePicture: "profilePicture",
    age:34,
    ffeLink: "FFELink",
    phoneNumber: "phoneNumber",
    role:UserRole.manager.toShortString(),
    horses:[],
    createdAt:DateTime.now(),
    type:UserType.owner.toString(),
    userName: "Antony",
    password: "12345",
    email: "antony@gmail.com",
  );

  static User userRiderDp = User(
    id:"id3",
    profilePicture: "profilePicture",
    age:34,
    ffeLink: "FFELink brian",
    phoneNumber: "phoneNumber",
    role:UserRole.rider.toShortString(),
    horses:[],
    createdAt:DateTime.now(),
    type:UserType.dp.toString(),
    userName: "Brian",
    password: "12345",
    email: "brian@gmail.com",
  );

  static User userRiderDp2 = User(
    id:"id3",
    profilePicture: "profilePicture",
    age:34,
    ffeLink: "FFELink brian",
    phoneNumber: "phoneNumber",
    role:UserRole.rider.toShortString(),
    horses:[],
    createdAt:DateTime.now(),
    type:UserType.dp.toString(),
    userName: "Brian",
    password: "12345",
    email: "brian@gmail.com",
  );

  static Horse horse = Horse(
    id: "id1",
    dpUsers: [],
    owner: null,
    picturePath: "path cheval",
    age: 3,
    dress: "brown",
    createdAt: DateTime.now(),
    name: "Etoile d'argent",
    race: HorseRace.pureSang.toShortString(),
    speciality: Speciality.endurance.toShortString(),
    gender: Gender.female.toShortString()
  );

  static Horse horse2 = Horse(
    id: "id2",
    dpUsers: [],
    owner: null,
    picturePath: "path pegase",
    age: 5,
    dress: "brown",
    createdAt: DateTime.now(),
    name: "Pegase",
    race: HorseRace.pureSang.toShortString(),
    speciality: Speciality.complete.toShortString(),
    gender: Gender.male.toShortString()
  );


  /*
  user: User(
      id:"id3",
      profilePicture: "profilePicture",
      age:34,
      ffeLink: "FFELink brian",
      phoneNumber: "phoneNumber",
      role:UserRole.rider.toShortString(),
      horses:[],
      createdAt:DateTime.now(),
      type:UserType.dp.toString(),
      userName: "Brian",
      password: "12345",
      email: "brian@gmail.com",
    ),
  * */
  static Party party = Party(
    user: '156461',
    name: "party tonight",
    id: "id1",
    picturePath: "picture path party",
    attendeesParty: [],
    theme: ThemeParty.happyHour.toShortString(),
    isValid: true,
    createdAt: DateTime.now(),
    partyDateTime: DateTime.now(),
  );

  static Lesson lesson = Lesson(
    id: "id1",
    attendees:[],
    name: "saut d'obstacle",
    user: 'userManagerOwner',
    ground: Ground.carousel.toString(),
    lessonDateTime: DateTime.now(),
    createdAt: DateTime.now(),
    duration: 30,
    discipline: Discipline.endurance.toString(),
    isValid: true,
  );

  static Contest contest = Contest(
    id: "id1",
    attendeesContest: [],
    user: 'userRiderDp',
    name: "competition",
    address: "5 rue de l'oise",
    picturePath: "contest picture path",
    contestDateTime: DateTime.now(),
    createdAt: DateTime.now(),
    isValid: true,
  );
}
