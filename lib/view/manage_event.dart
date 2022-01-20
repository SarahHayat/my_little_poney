import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/view/component/column_list.dart';
import 'package:my_little_poney/view/component/contest_tile.dart';
import 'package:my_little_poney/view/component/custom_datepicker.dart';
import 'package:my_little_poney/view/component/lesson_tile.dart';
import 'package:my_little_poney/view/component/yes_no_dialog.dart';

class ManageEvent extends StatefulWidget {
  const ManageEvent({Key? key}) : super(key: key);
  static const tag = "manage_event";

  @override
  State<ManageEvent> createState() => _ManageEventState();
}

class _ManageEventState extends State<ManageEvent> {
  final User currentUser = Mock.userManagerOwner2;
  late List<Contest> allContest ;
  List<Contest> displayedContest = [];
  late List<Lesson> allLessons ;
  List<Lesson> displayedLessons = [];

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getLessons();
    _getContest();
    _filterEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lessons / Contest : ${selectedDate.getFrenchDate()}"),
          elevation: 10,
          centerTitle: true,
          leading: CustomDatePicker(initialDate: selectedDate, onSelected: _updateSelectedDate,)
        ),
        body: _buildScaffoldBody()
    );
  }

  /// Used in CustomDatePicker to update [selectedDate] with [date] value.
  /// Then filter events.
  _updateSelectedDate(DateTime date){
    setState(() {
      selectedDate = date;
    });
    _filterEvents();
  }

  /// Create the body of this screen.
  /// If the current user is a manager, then he can see the panel.
  /// Else, we display a message to unespected user
  _buildScaffoldBody(){
    if(currentUser.isManager()){
      return Row(
        children: [
          ColumnList(title: "Lessons", icon: Icon(Icons.school_outlined), child: ListViewSeparated(data: displayedLessons, buildListItem: _buildItemLesson)),
          ColumnList(title: "Contests", icon: Icon(Icons.emoji_events_outlined), child: ListViewSeparated(data: displayedContest, buildListItem: _buildItemContest)),
        ]
      );
    }
    else{
      return const Center(
        child : Text("This page is reserved to admin", textScaleFactor: 1.5,)
      );
    }
  }

  /// Create a Lesson item for a ListView
  Widget _buildItemLesson(Lesson lesson) {
    return LessonTile(
      lesson: lesson,
      onTap: (){
        dialogueLesson(lesson);
      }
    );
  }

  /// Create a Contest item for a ListView
  Widget _buildItemContest(Contest contest) {
    return ContestTile(
      contest: contest,
      onTap: (){
        dialogueContest(contest);
      },
    );
  }

  //region dialog
  /// Display a [YesNoDialog] to validate or reject a lesson
  Future<Null> dialogueLesson(Lesson lesson) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return YesNoDialog(
            title: "Validate this lesson?",
            children: [
              Text("${lesson.name} will be validate."),
            ],
            trueFunction: ()=>_updateLesson(lesson, true),
            falseFunction: ()=>_updateLesson(lesson, false),
          );
        }
    );
  }

  /// Display a [YesNoDialog] to validate or reject a contest
  Future<Null> dialogueContest(Contest contest) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return YesNoDialog(
            title: "Validate this contest?",
            children: [
              Text("${contest.name} will be validate."),
            ],
            trueFunction: ()=>_updateContest(contest, true),
            falseFunction: ()=>_updateContest(contest, false),
          );
        }
    );
  }
  //endregion

  //region api call & front setting
  _updateLesson(Lesson lesson, bool isValid){
    //@todo : add one more row to update data on this lesson in DB with a request
    log("Update lesson ${lesson.name} $isValid");
    setState(() {
      //need a method to update lesson validate bool
      //allLessons.remove(lesson);
    });
  }

  _updateContest(Contest contest, bool isValid){
    //@todo : add one more row to update data on this contest in DB with a request
    log("Update contest ${contest.name} $isValid");
    setState(() {
      //need a method to update contest validate bool
      //allLessons.remove(lesson);
    });
  }

  _getLessons(){
    //@todo : use request here to get lessons list from DB
    //il faut qu'on ai une gestion par semaine
    setState(() {
      allLessons = [Mock.lesson, Mock.lesson,Mock.lesson, Mock.lesson, Mock.lesson];
    });
  }

  _getContest(){
    //@todo : use request here to get contest list from DB
    //il faut qu'on ai une gestion par semaine
    setState(() {
      allContest = [Mock.contest, Mock.contest];
    });
  }
  //endregion

  /// Filter events depending on [selectedDate] week
  void _filterEvents(){
    DateTime date = selectedDate.getOnlyDate();
    List<Lesson> lessonList = [];
    List<Contest> contestList = [];

    // condition for same day => allLessons[i].lessonDateTime.getOnlyDate() == date
    // condition for same week => allContest[i].contestDateTime.areDateSameWeek(date)
    for(int i=0; i<allLessons.length; i++){
      if(allLessons[i].lessonDateTime.areDateSameWeek(date)){
        lessonList.add(allLessons[i]);
      }
    }
    for(int i=0; i<allContest.length; i++){
      if(allContest[i].contestDateTime.areDateSameWeek(date)){
        contestList.add(allContest[i]);
      }
    }
    setState(() {
      displayedLessons = lessonList;
      displayedContest = contestList;
    });
  }

}
