import 'package:flutter/material.dart';
import 'package:my_little_poney/components/text_icon.dart';
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
            Text('date: ${lesson.lessonDateTime.getFrenchDateTime()}'),
            Text('end: ${lesson.lessonDateTime.addMinutesAndStringify(lesson.duration)}'),
            TextIcon(title: "accepted: ", icon:Icon(lesson.isValid ? Icons.check : Icons.do_not_disturb_on) ),
          ]
      ),
    );
  }
}
