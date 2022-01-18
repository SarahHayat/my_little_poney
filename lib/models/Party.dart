import 'User.dart';

enum Theme {
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
  String id;
  User user;
  Theme theme;
  String picturePath;
  List<AttendeeParty> attendeesParty;
  bool isValid;
  DateTime createdAt;

  Party(
    this.id,
    this.picturePath,
    this.attendeesParty, {
    required this.user,
    required this.theme,
    this.isValid = false,
    required this.createdAt,
  });
}
