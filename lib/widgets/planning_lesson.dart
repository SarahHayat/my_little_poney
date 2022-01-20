import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/components/custom_datepicker.dart';
import 'package:my_little_poney/components/daily_section_content.dart';
import 'package:my_little_poney/components/lesson_tile.dart';
import 'package:my_little_poney/usecase/lesson_usecase.dart';

import '../components/daily_section.dart';

class PlanningLesson extends StatefulWidget {
  const PlanningLesson({Key? key}) : super(key: key);
  static const tag = "planning_lesson";

  @override
  State<PlanningLesson> createState() => _PlanningLessonState();
}

class _PlanningLessonState extends State<PlanningLesson> {
  final LessonUseCase lessonUseCase = LessonUseCase();
  final User currentUser = Mock.userManagerOwner2;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  /// Filter lessons depending on [selectedDate] week
  Map<DateTime, List<Lesson>> _filterLessonsOfWeek(Map<DateTime, List<Lesson>> mappedLesson){
    DateTime mondayOfWeek = selectedDate.getWeekFirstDay();
    Map<DateTime, List<Lesson>> lessonList = {};
    for(int i=0; i<DateTime.sunday; i++){
      DateTime weekDay = mondayOfWeek.add(Duration(days: i));
      lessonList[weekDay] = mappedLesson.keys.contains(weekDay) ? mappedLesson[weekDay] as List<Lesson> : [];
    }
    return lessonList;
  }

  _getDailyLessons(List<Lesson> data){
    Map<DateTime, List<Lesson>> lessonsMap = {};
    data.forEach((element) {
      if(!lessonsMap.containsKey(element.lessonDateTime.getOnlyDate())){
        lessonsMap[element.lessonDateTime.getOnlyDate()] = [];
      }
      lessonsMap[element.lessonDateTime.getOnlyDate()]?.add(element);
    });
    Map<DateTime, List<Lesson>> dailyLessons = _filterLessonsOfWeek(lessonsMap);
    List<Widget> t = [];
    dailyLessons.forEach((key, value) {
      t.add(_buildPlanning(key, value));
    });
    return t;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lesson planning week : ${selectedDate.getWeekFirstDay().getFrenchDate()}"),
        elevation: 10,
        centerTitle: true,
        leading: CustomDatePicker(initialDate: selectedDate, onSelected: _updateSelectedDate,),
      ),
      body: FutureBuilder<List<Lesson>?>(
      future: getAllLessons(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Lesson> data = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _getDailyLessons(data),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(
              child: CircularProgressIndicator()
          );
        },
      )
    );
  }

  /// Used in CustomDatePicker to update [selectedDate] with [date] value.
  /// Then filter lessons.
  _updateSelectedDate(DateTime date){
    setState(() {
      selectedDate = date;
    });
  }

  /// Create a widget for the given date that will display the [date],
  /// and allow to see the associated lessons in a dialog on click on
  /// this section.
  _buildPlanning(DateTime date, List<Lesson> dailyLessons){
    int nbLessons = dailyLessons.length;
    return DailySection(
      date: date,
      child: DailySectionContent(date: date, resume:"$nbLessons lesson${nbLessons>1 ? "s" : ""}" ,),
      onPressed: (){
        if(nbLessons>0) {
          dialogue(date, dailyLessons);
        }
      },
    );
  }

  /// Display a dialog containing a listView of all leasons for the day
  Future<Null> dialogue(DateTime day, List<Lesson> dailyLesson) async{
    double width = MediaQuery.of(context).size.width *0.75;
    double height = MediaQuery.of(context).size.height *0.75;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            title: Text("${day.getWeekDayName()} Lesson"),
            contentPadding: EdgeInsets.all(5.0),
            children: [
              Container(
                height: height,
                width: width,
                child: ListViewSeparated(data: dailyLesson,buildListItem: _buildRow),
              )
            ],
          );
        }
    );
  }

  Widget _buildRow(Lesson lesson) {
    return LessonTile(lesson: lesson,);
  }

  Future<List<Lesson>?> getAllLessons() async {
    final result = await lessonUseCase.getAllLessons();
    log(result.toString());
    return result;
  }
}
