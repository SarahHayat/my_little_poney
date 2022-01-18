import 'package:flutter/material.dart';
import 'package:my_little_poney/models/Horse.dart';

Icon getGenderIcon(Gender gender){
  switch (gender) {
    case Gender.male:
      return Icon(Icons.male);
    case Gender.female:
      return Icon(Icons.female);
    case Gender.other:
      return Icon(Icons.science_outlined);
    default:
      return Icon(Icons.male);
  }
}