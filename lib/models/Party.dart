import 'User.dart';

enum ThemeParty {
  happyHour,
  dinner,
}

class AttendeeParty {
  User user;
  String comment;

  AttendeeParty(
    this.comment, {
    required this.user,
  });
}

class Party {
  String? id;
  User user;
  String theme;
  String? picturePath;
  List<AttendeeParty>? attendeesParty;
  bool isValid;
  DateTime createdAt;
  DateTime partyDateTime;

  Party({
    this.id,
    this.picturePath,
    this.attendeesParty,
    required this.user,
    required this.theme,
    this.isValid = false,
    required this.createdAt,
    required this.partyDateTime,
  });

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      id: json['id'] != null ? json['id']! as String : "",
      picturePath: json['picturePath'] != null ? json['picturePath']! as String : "",
      attendeesParty: json['attendeesParty'] != null ? json['attendeesParty']! as List<AttendeeParty> : [],
      user: json['user'] as User,
      theme: json['theme'] as String,
      isValid: json['isValid']  as bool,
      createdAt: DateTime.parse(json['createdAt']! as String),
      partyDateTime: DateTime.parse(json['partyDateTime']! as String),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'picturePath': picturePath,
      'attendeesParty': attendeesParty,
      'user': user,
      'theme': theme,
      'isValid': isValid,
      'createdAt': createdAt,
      'partyDateTime': partyDateTime,
    };
  }
}
