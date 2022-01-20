import 'package:flutter/material.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/view/component/lesson_resume.dart';

class LessonTile extends StatelessWidget {
  const LessonTile({Key? key, required this.lesson, this.onTap}) : super(key: key);
  final Lesson lesson;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: (){
          onTap!();
        },
        title: Container(
          child:Text( "${lesson.name} - ${lesson.discipline}" ),
        ),
        subtitle: LessonResume(lesson: lesson,)
    );
  }
}
