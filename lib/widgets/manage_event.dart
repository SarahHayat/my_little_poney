import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_little_poney/components/yes_no_dialog.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Party.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/components/column_list.dart';
import 'package:my_little_poney/components/party_tile.dart';
import 'package:my_little_poney/components/custom_datepicker.dart';
import 'package:my_little_poney/components/lesson_tile.dart';
import 'package:my_little_poney/usecase/lesson_usecase.dart';
import 'package:my_little_poney/usecase/party_usecase.dart';

import '../components/party_tile.dart';

class ManageEvent extends StatefulWidget {
  const ManageEvent({Key? key}) : super(key: key);
  static const tag = "manage_event";

  @override
  State<ManageEvent> createState() => _ManageEventState();
}

class _ManageEventState extends State<ManageEvent> {
  final LessonUseCase lessonUseCase = LessonUseCase();
  final PartyUseCase partyUseCase = PartyUseCase();
  final User currentUser = Mock.userManagerOwner2;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lessons / Party : ${selectedDate.getFrenchDate()}"),
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
  }

  /// Create the body of this screen.
  /// If the current user is a manager, then he can see the panel.
  /// Else, we display a message to unespected user
  _buildScaffoldBody(){
    if(currentUser.isManager()){
      return Row(
        children: [
          FutureBuilder<List<Lesson>?>(
            future: getAllLessons(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Lesson> data = snapshot.data!;
                List<Lesson> displayedLessons = _filterLessons(data);
                return ColumnList(
                    title: "Lessons",
                    icon: Icon(Icons.school_outlined),
                    child: ListViewSeparated(data: displayedLessons, buildListItem: _buildItemLesson)
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(
                  child: CircularProgressIndicator()
              );
            },
          ),
          FutureBuilder<List<Party>?>(
            future: getAllParties(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Party> data = snapshot.data!;
                List<Party> displayedParties = _filterParty(data);
                return ColumnList(
                    title: "Partys",
                    icon: Icon(Icons.liquor_sharp),
                    child: ListViewSeparated(data: displayedParties, buildListItem: _buildItemParty)
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(
                  child: CircularProgressIndicator()
              );
            },
          ),
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

  /// Create a Party item for a ListView
  Widget _buildItemParty(Party party) {
    return PartyTile(
      party: party,
      onTap: (){
        dialogueParty(party);
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

  /// Display a [YesNoDialog] to validate or reject a party
  Future<Null> dialogueParty(Party party) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return YesNoDialog(
            title: "Validate this party?",
            children: [
              Text("${party.theme} will be validate."),
            ],
            trueFunction: ()=>_updateParty(party, true),
            falseFunction: ()=>_updateParty(party, false),
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

  _updateParty(Party party, bool isValid){
    //@todo : add one more row to update data on this party in DB with a request
    log("Update party ${party.theme} $isValid");
    setState(() {
      //need a method to update party validate bool
      //allLessons.remove(lesson);
    });
  }

  Future<List<Lesson>?> getAllLessons() async {
    return await lessonUseCase.getAllLessons();
  }

  Future<List<Party>?> getAllParties() async {
    return await partyUseCase.getAllParties();
  }
  //endregion

  List<Lesson> _filterLessons(List<Lesson> allLessons){
    DateTime date = selectedDate.getOnlyDate();
    List<Lesson> lessonList = [];
    for(int i=0; i<allLessons.length; i++){
      if(allLessons[i].lessonDateTime.areDateSameWeek(date)){
        lessonList.add(allLessons[i]);
      }
    }
    return lessonList;
  }

  /// Filter events depending on [selectedDate] week
  /// condition for same day => allLessons[i].lessonDateTime.getOnlyDate() == date
  /// condition for same week => allParty[i].partyDateTime.areDateSameWeek(date)
  List<Party> _filterParty(List<Party> allParty){
    DateTime date = selectedDate.getOnlyDate();
    List<Party> partyList = [];

    for(int i=0; i<allParty.length; i++){
      if(allParty[i].partyDateTime.areDateSameWeek(date)){
        partyList.add(allParty[i]);
      }
    }
    return partyList;
  }

}
