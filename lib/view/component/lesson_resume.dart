import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
import 'package:my_little_poney/models/Lesson.dart';

class LessonResume extends StatelessWidget {
  const LessonResume({Key? key, required this.lesson}) : super(key: key);
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text('duration: ${lesson.duration}'),
            Text('date: ${lesson.lessonDateTime.getFrenchDateTime()}'),
          ]
      ),
    );
  }
}
