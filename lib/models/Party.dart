import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/string_extension.dart';

import 'User.dart';

enum Theme {
  happyHour,
  dinner,
}
extension ThemeExtension on Theme {
  Icon getIcon() {
    switch (this) {
      case Theme.happyHour:
        return Icon(Icons.nightlife_outlined);
      case Theme.dinner:
        return Icon(Icons.wine_bar_outlined);
      default:
        return Icon(Icons.wine_bar_outlined);
    }
  }

  String toShortString() {
    return this.toString().enumValueToNormalCase();
  }
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
