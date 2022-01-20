import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/view/component/custom_datepicker.dart';
import 'package:my_little_poney/view/component/daily_section_content.dart';
import 'package:my_little_poney/view/component/lesson_tile.dart';

import 'component/daily_section.dart';

class PlanningLesson extends StatefulWidget {
  const PlanningLesson({Key? key}) : super(key: key);
  static const tag = "planning_lesson";

  @override
  State<PlanningLesson> createState() => _PlanningLessonState();
}

class _PlanningLessonState extends State<PlanningLesson> {
  final User currentUser = Mock.userManagerOwner2;
  late Map<DateTime, List<Lesson>> allLessons ;
  late Map<DateTime, List<Lesson>> displayedLessons ;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getLessons();
    _filterLessonsOfWeek();
  }

  /// Filter lessons depending on [selectedDate] week
  void _filterLessonsOfWeek(){
    DateTime mondayOfWeek = selectedDate.getWeekFirstDay();
    Map<DateTime, List<Lesson>> lessonList = {};
    for(int i=0; i<DateTime.sunday; i++){
      DateTime weekDay = mondayOfWeek.add(Duration(days: i));
      lessonList[weekDay] = allLessons.keys.contains(weekDay) ? allLessons[weekDay] as List<Lesson> : [];
    }
    setState(() {
      displayedLessons = lessonList;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> t = [];
    displayedLessons.forEach((key, value) {
      t.add(_buildPlanning(key, value));
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Lesson planning week : ${selectedDate.getWeekFirstDay().getFrenchDate()}"),
        elevation: 10,
        centerTitle: true,
        leading: CustomDatePicker(initialDate: selectedDate, onSelected: _updateSelectedDate,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: t,
      )
    );
  }

  /// Used in CustomDatePicker to update [selectedDate] with [date] value.
  /// Then filter lessons.
  _updateSelectedDate(DateTime date){
    setState(() {
      selectedDate = date;
    });
    _filterLessonsOfWeek();
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

  _getLessons(){
    //@todo : use request here to get lessons list from DB
    //il faut qu'on ai une gestion par semaine

    setState(() {
      allLessons = {
        _fakeDate(DateTime.monday):[Mock.lesson, Mock.lesson],
        _fakeDate(DateTime.tuesday):[Mock.lesson],
        _fakeDate(DateTime.wednesday):[],
        _fakeDate(DateTime.thursday):[Mock.lesson, Mock.lesson, Mock.lesson, Mock.lesson],
        _fakeDate(DateTime.friday):[Mock.lesson],
        _fakeDate(DateTime.saturday):[Mock.lesson],
        _fakeDate(DateTime.sunday):[Mock.lesson],
        _fakeDate(8):[Mock.lesson],
        _fakeDate(9):[Mock.lesson, Mock.lesson, Mock.lesson, Mock.lesson],
      };
    });

  }

  ///@todo : delete this function.
  ///  For Dev only, used to fake lesson planning.
  DateTime _fakeDate(int weekdayInt){
    int sundayDate = 16;
    return DateTime.parse("2022-01-${sundayDate + weekdayInt}");
  }
}
