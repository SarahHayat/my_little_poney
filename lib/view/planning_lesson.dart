import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
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
  final Map<DateTime, Map<String, List<Lesson>>> weeksLessons = {};
  DateTime selectedDate = DateTime.now();

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
        title: Text("Lesson planning week : ${selectedDate.getWeekFirstDay().getFrenchDate()}"),
        elevation: 10,
        centerTitle: true,
        leading: ElevatedButton(
          onPressed: (){
            _selectDate(context);
          },
          child: Icon(Icons.calendar_today),
        ),
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

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
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
    //il faut qu'on ai une gestion par semaine

    setState(() {
      lessons = {
        _fakeDate(DateTime.monday):[Mock.lesson, Mock.lesson],
        _fakeDate(DateTime.tuesday):[Mock.lesson],
        _fakeDate(DateTime.wednesday):[],
        _fakeDate(DateTime.thursday):[Mock.lesson, Mock.lesson, Mock.lesson, Mock.lesson],
        _fakeDate(DateTime.friday):[Mock.lesson],
        _fakeDate(DateTime.saturday):[Mock.lesson],
        _fakeDate(DateTime.sunday):[Mock.lesson],
      };
      weeksLessons[DateTime.now().getWeekFirstDay()] = lessons;
      weeksLessons[DateTime.now().add(Duration(days: 30)).getWeekFirstDay()] = lessons;
      log(weeksLessons.keys.toString());
    });

  }

  String _fakeDate(int weekdayInt){
    int sundayDate = 16;
    log(DateTime.parse("2022-01-${sundayDate + weekdayInt}").getWeekFirstDay().toString());
    return DateTime.parse("2022-01-${sundayDate + weekdayInt}").getWeekDayName();
  }
}
