import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/User.dart';

import 'lesson_resume.dart';

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
        leading: ElevatedButton(
          onPressed: (){
            _selectDate(context);
          },
          child: Icon(Icons.calendar_today),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: t,
      )
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
      _filterLessonsOfWeek();
    }
  }

  _buildPlanning(DateTime date, List<Lesson> daylyLessons){
    int nbLessons = daylyLessons.length;
    //(nbLessons>0 ? Colors.white : Colors.grey[100])
    return Expanded(
        flex: 1,
        child:Container(
            child:TextButton(
              child: _buildButtonDetails(date, daylyLessons),
              //style: ElevatedButton.styleFrom(primary: (nbLessons>0 ? Colors.blue[300] : Colors.grey[600])),
              onPressed: (){
                if(nbLessons>0) {
                  dialogue(date, daylyLessons);
                }
              },
            )
        )
    );
  }

  Widget _buildButtonDetails(DateTime  date, List<Lesson> daylyLessons){
    int nbLessons = daylyLessons.length;
    return  Container(
      alignment: Alignment.centerLeft,
      child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Row(
          children: [
            Icon(
                date.compareTo(DateTime.now().getOnlyDate())>=0 ? Icons.school_outlined : Icons.do_not_disturb_on,
                color: date.getWeekDayColor(),
            ),
            Container(width: 10,),
            Text("${date.getWeekDayName()}, ${date.day} ${date.getMonthName()}" ),
          ],
        ),
        Text("$nbLessons lesson${nbLessons>1 ? "s" : ""}" ),
      ]
      ),
    );
  }

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
                child: ListViewSeparated(data: dailyLesson,buildRow: _buildRow),
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
      subtitle: LessonResume(lesson: lesson,)
    );
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

  DateTime _fakeDate(int weekdayInt){
    int sundayDate = 16;
    return DateTime.parse("2022-01-${sundayDate + weekdayInt}");
  }
}
