import 'package:my_little_poney/helper/string_extension.dart';

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
extension DisciplineExtension on Discipline {
  String toShortString() {
    return this.toString().enumValueToNormalCase();
  }
}

class Lesson {
  String? id;
  String name;
  String user;
  String ground;
  DateTime lessonDateTime;
  DateTime createdAt;
  int duration;
  String discipline;
  List<dynamic>? attendees;
  bool isValid;

  Lesson({
    this.id,
    this.attendees,
    required this.name,
    required this.user,
    required this.ground,
    required this.lessonDateTime,
    required this.createdAt,
    required this.duration,
    required this.discipline,
    this.isValid = false,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['_id'] != null ? json['_id']! as String : "",
      attendees:
          json['attendees'] != null ? json['attendees']! as List<dynamic> : [],
      name: json['name'] as String,
      user: json['user'] as String,
      ground: json['ground'] as String,
      lessonDateTime: DateTime.parse(json['lessonDateTime']! as String),
      createdAt: DateTime.parse(json['createdAt']! as String),
      duration: json['duration'] as int,
      discipline: json['discipline'] as String,
      isValid: json['isValid'] as bool,
    );
  }

  Map<String, Object?> toJson() {
    return {
      '_id': id,
      'attendees': attendees,
      'name': name,
      'user': user,
      'ground': ground,
      'lessonDateTime': lessonDateTime,
      'createdAt': createdAt,
      'duration': duration,
      'discipline': discipline,
      'isValid': isValid,
    };
  }
}
