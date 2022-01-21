import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/string_extension.dart';

import 'User.dart';

enum ThemeParty {
  happyHour,
  dinner,
}
extension ThemePartyExtension on ThemeParty {
  Icon getIcon() {
    switch (this) {
      case ThemeParty.happyHour:
        return Icon(Icons.nightlife_outlined);
      case ThemeParty.dinner:
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
  String? id;
  String name;
  String user;
  String theme;
  String? picturePath;
  List<AttendeeParty>? attendeesParty;
  bool isValid;
  DateTime createdAt;
  DateTime partyDateTime;

  Party({
    this.id,
    required this.name,
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
      id: json['_id'] != null ? json['_id']! as String : "",
      name: json['name'] as String,
      picturePath: json['picturePath'] != null ? json['picturePath']! as String : "",
      attendeesParty: json['attendeesParty'] != null ? json['attendeesParty']! as List<AttendeeParty> : [],
      user: json['user'] as String,
      theme: json['theme'] as String,
      isValid: json['isValid'] as bool,
      createdAt: DateTime.parse(json['createdAt']! as String),
      partyDateTime: DateTime.parse(json['partyDateTime']! as String),
    );
  }

  Map<String, Object?> toJson() {
    return {
      '_id': id,
      'name': name,
      'picturePath': picturePath,
      'attendeesParty': [], // @todo : use the attendees list ---> attendeesParty,
      'user': user,
      'theme': theme,
      'isValid': isValid,
      'createdAt': createdAt.toString(),
      'partyDateTime': partyDateTime.toString(),
    };
  }
}
