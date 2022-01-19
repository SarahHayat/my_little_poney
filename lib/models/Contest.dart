import 'User.dart';

enum Level {
  amateur,
  club1,
  club2,
  club3,
  club4,
}

class AttendeeContest {
  Level level;
  User user;

  AttendeeContest({
    required this.user,
    required this.level,
  });
}

class Contest {
  String id;
  User user;
  String name;
  String address;
  String picturePath;
  DateTime contestDateTime;
  DateTime createdAt;
  List<AttendeeContest> attendeesContest;
  bool isValid;
  String eventType;

  Contest(this.id, this.attendeesContest,
      {required this.user,
      required this.name,
      required this.address,
      required this.picturePath,
      required this.contestDateTime,
      required this.createdAt,
      this.isValid = false,
      this.eventType = 'contest'
      });
}
