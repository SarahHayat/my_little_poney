import 'User.dart';

enum Themes {
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
  String name;
  User user;
  Themes theme;
  String picturePath;
  List<AttendeeParty> attendeesParty;
  bool isValid;
  DateTime createdAt;
  DateTime partyDateTime;
  String eventType;

  Party(
    this.id,
    this.name,
    this.picturePath,
    this.attendeesParty, {
    required this.partyDateTime,
    required this.user,
    required this.theme,
    this.isValid = false,
    required this.createdAt,
    this.eventType = 'party',
  });
}
