import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/User.dart';

class PlanningLesson extends StatefulWidget {
  const PlanningLesson({Key? key}) : super(key: key);
  static const tag = "planning_lesson";

  @override
  State<PlanningLesson> createState() => _PlanningLessonState();
}

class _PlanningLessonState extends State<PlanningLesson> {
  final User currentUser = Mock.userManagerOwner2;
  late Map<String, List<Lesson>> lessons ;

  @override
  void initState() {
    super.initState();
    _getLessons();
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = MediaQuery.of(context).size.height / 7;
    List<Widget> t = [];
    lessons.forEach((key, value) {
      t.add(_buildPlanning(rowHeight, key, value));
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Lesson planning"),
        elevation: 10,
        centerTitle: true,
      ),
      body:GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisExtent: 200
        ),
        scrollDirection: Axis.horizontal,
        children: t,
      )
      /*body: Column(
        children: t,
      )*/
    );
  }

  _buildPlanning(double height, String day, List<Lesson> daylyLessons){
    int nbLessons = daylyLessons.length;
    return Container(
      height: height,
      child: TextButton(
        child: Container(
          alignment: Alignment.centerLeft,
          child:Text(
            "$day - $nbLessons cour${nbLessons>1 ? "s" : ""}",
          ),
        ),
        onPressed: (){
          dialogue(day, daylyLessons );
        },
      ),
    );
  }

  Future<Null> dialogue(String day, List<Lesson> dailyLesson) async{
    double width = MediaQuery.of(context).size.width *0.75;
    double height = MediaQuery.of(context).size.height *0.75;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            title: Text("$day Lesson"),
            contentPadding: EdgeInsets.all(5.0),
            children: [
              Container(
                height: height,
                width: width,
                child: buildListView(dailyLesson, _buildRow),
              )
            ],
          );
        }
    );
  }

  Widget _buildRow(Lesson lesson) {
    return ListTile(
      tileColor: (lesson.attendees.contains(currentUser) ? Colors.greenAccent : Colors.white),
      title: Container(
        child:Text( "${lesson.name} - ${lesson.discipline}" ),
      ),
      subtitle: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text('duration: ${lesson.duration}'),
            ]
        ),
      ),
    );
  }

  _getLessons(){
    //@todo : use request here to get lessons list from DB
    setState(() {
      lessons = {
        "monday":[Mock.lesson, Mock.lesson],
        "tuesday":[Mock.lesson],
        "wednesday":[],
        "thursday":[Mock.lesson, Mock.lesson, Mock.lesson, Mock.lesson],
        "friday":[Mock.lesson],
        "saturday":[Mock.lesson],
        "sunday":[Mock.lesson],
      };
    });
  }
}



