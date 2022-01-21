import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/string_extension.dart';

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
  String user;
  String comment;

  AttendeeParty(
    this.comment, {
    required this.user,
  });

  Map<String, Object?> toJson() {
    return {
      'comment': comment,
      'user': user,
    };
  }
}

class Party {
  String? id;
  String name;
  String user;
  String theme;
  String? picturePath;
  List<dynamic> attendeesParty;
  bool isValid;
  DateTime? createdAt;
  DateTime partyDateTime;

  Party({
    this.id,
    required this.name,
    this.picturePath,
    required this.attendeesParty,
    required this.user,
    required this.theme,
    this.isValid = false,
    this.createdAt,
    required this.partyDateTime,
  });

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      id: json['_id'] != null ? json['_id']! as String : "",
      name: json['name'] as String,
      picturePath:
          json['picturePath'] != null ? json['picturePath']! as String : "",
      attendeesParty:
          json['attendees'] != null ? json['attendees']! as List<dynamic> : [],
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
      'attendees': attendeesParty,
      'user': user,
      'theme': theme,
      'isValid': isValid,
      'createdAt': createdAt.toString(),
      'partyDateTime': partyDateTime.toString(),
    };
  }
}
