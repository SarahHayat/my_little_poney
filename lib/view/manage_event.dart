import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/view/confirm_deletion_button.dart';

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

  void _filterEvents(){
    DateTime date = selectedDate.getOnlyDate();
    List<Lesson> lessonList = [];
    List<Contest> contestList = [];
    for(int i=0; i<allLessons.length; i++){
      if(allLessons[i].lessonDateTime.getOnlyDate() == date ){
        lessonList.add(allLessons[i]);
      }
    }
    for(int i=0; i<allContest.length; i++){
      if(allContest[i].contestDateTime.getOnlyDate() == date ){
        contestList.add(allContest[i]);
      }
    }
    setState(() {
      displayedLessons = lessonList;
      displayedContest = contestList;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> t = [];
    return Scaffold(
        appBar: AppBar(
          title: Text("Lessons / Contest : ${selectedDate.getFrenchDate()}"),
          elevation: 10,
          centerTitle: true,
          leading: ElevatedButton(
            onPressed: (){
              _selectDate(context);
            },
            child: Icon(Icons.calendar_today),
          ),
        ),
        body: _buildScaffoldBody()
    );
  }

  _buildScaffoldBody(){
    if(currentUser.isManager()){
      return Row(
        children: [
          Expanded(flex:1, child:buildListView(displayedLessons, _buildRowLesson)),
          Expanded(flex:1, child:buildListView(displayedContest, _buildRowContest)),
        ]
      );
    }
    else{
      return Center(
        child : Text("This page is reserved to admin", textScaleFactor: 1.5,)
      );
    }
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
        _filterEvents();
      });
    }
  }

  Widget _buildRowLesson(Lesson lesson) {
    return ListTile(
      onTap: (){
        dialogueLesson(lesson);
      },
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

  Widget _buildRowContest(Contest contest) {
    return ListTile(
      onTap: (){
        dialogueContest(contest);
      },
      title: Container(
        child:Text( "${contest.name} - ${contest.address}" ),
      ),
      subtitle: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text('date: ${contest.contestDateTime.getFrenchDateTime()}'),
            ]
        ),
      ),
    );
  }

  Future<Null> dialogueLesson(Lesson lesson) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            title: Text("Validate this lesson?"),
            contentPadding: EdgeInsets.all(20.0),
            children: [
              Text("${lesson.name} will be validate."),
              Container(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ConfirmDeletionButton(true, context, trueFunction: ()=>_updateLesson(lesson, true),),
                  ConfirmDeletionButton(false, context, falseFunction: ()=>_updateLesson(lesson, false),),
                ],
              ),
            ],
          );
        }
    );
  }

  Future<Null> dialogueContest(Contest contest) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            title: Text("Validate this contest?"),
            contentPadding: EdgeInsets.all(20.0),
            children: [
              Text("${contest.name} will be validate."),
              Container(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ConfirmDeletionButton(true, context, trueFunction: ()=>_updateContest(contest, true),),
                  ConfirmDeletionButton(false, context, falseFunction: ()=>_updateContest(contest, false),),
                ],
              ),
            ],
          );
        }
    );
  }

  _updateLesson(Lesson lesson, bool isValid){
    //@todo : add one more row to update data on this lesson in DB with a request
    setState(() {
      //le modele devrait permettre d'update son etat
      //allLessons.remove(lesson);
    });
  }

  _updateContest(Contest contest, bool isValid){
    //@todo : add one more row to update data on this contest in DB with a request
    setState(() {
      //le modele devrait permettre d'update son etat
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
}
