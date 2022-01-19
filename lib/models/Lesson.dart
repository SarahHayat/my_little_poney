import 'User.dart';

enum Ground {
  carousel,
  arena,
}

enum Discipline {
  dressage,
  showJumping,
  endurance,
}

class Lesson {
  String id;
  String name;
  User user;
  Ground ground;
  DateTime lessonDateTime;
  DateTime createdAt;
  int duration;
  Discipline discipline;
  List<User> attendees;
  bool isValid;
  String eventType;

  Lesson(this.id, this.attendees,
      {required this.name,
      required this.user,
      required this.ground,
      required this.lessonDateTime,
      required this.createdAt,
      required this.duration,
      required this.discipline,
      this.isValid = false,
      this.eventType = 'lesson'
      });
}
