import 'User.dart';

enum Level {
  amateur,
  club1,
  club2,
  club3,
  club4,
}

class AttendeeContest {
  String level;
  String user;

  AttendeeContest({
    required this.user,
    required this.level,
  });

  factory AttendeeContest.fromJson(Map<String, dynamic> json) {
    return AttendeeContest(
      user: json['user'] != null ? json['user']! as String : "",
      level: json['user'] != null ? json['user']! as String : "",
    );
  }

  Map<String, Object?> toJson() {
    return {
      'user': user,
      'level': level,
    };
  }
}

class Contest {
  String? id;
  String user;
  String name;
  String address;
  String picturePath;
  DateTime contestDateTime;
  DateTime? createdAt;
  List<AttendeeContest> attendeesContest;
  bool isValid;

  Contest({
    this.id,
    required this.attendeesContest,
    required this.user,
    required this.name,
    required this.address,
    required this.picturePath,
    required this.contestDateTime,
    this.createdAt,
    this.isValid = false,
  });

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      id: json['_id'] != null ? json['_id']! as String : "",
      attendeesContest: json['attendeesContest'] != null
          ? json['attendeesContest']! as List<AttendeeContest>
          : [],
      user: json['user'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      picturePath:
          json['picturePath'] != null ? json['picturePath']! as String : "",
      contestDateTime: DateTime.parse(json['contestDateTime']! as String),
      createdAt: DateTime.parse(json['createdAt']! as String),
      isValid: json['isValid'] as bool,
    );
  }

  Map<String, Object?> toJson() {
    return {
      '_id': id,
      'attendeesContest': attendeesContest,
      'user': user,
      'name': name,
      'address': address,
      'picturePath': picturePath,
      'contestDateTime': contestDateTime.toString(),
      'createdAt': createdAt.toString(),
      'isValid': isValid
    };
  }
}
