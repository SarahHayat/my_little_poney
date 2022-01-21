import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_little_poney/components/background_image.dart';
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
  late bool isUpdated;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lessons / Parties : ${selectedDate.getFrenchDate()}"),
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
          ColumnList(
            title: "Lessons",
            icon: Icon(Icons.school_outlined),
            child: Container(
              decoration: BackgroundImageDecoration("https://www.ouestfrance-emploi.com/sites/default/files/styles/610-largeur/public/fiches_metiers/229_133260290.jpg?itok=2Kh18dtD"),
              child: FutureBuilder<List<Lesson>?>(
                future: getAllLessons(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Lesson> data = snapshot.data!;
                    List<Lesson> displayedLessons = _filterLessons(data);
                    return  ListViewSeparated(data: displayedLessons, buildListItem: _buildItemLesson);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Center(
                      child: CircularProgressIndicator()
                  );
                },
              ),
            ),
          ),
          ColumnList(
            title: "Parties",
            icon: Icon(Icons.liquor_sharp),
            child:Container(
              decoration: BackgroundImageDecoration("https://94.citoyens.com/wp-content/blogs.dir/2/files/2020/04/stocklib-dmitry-moiseenko-fete-apero-verres.jpg"),
              child: FutureBuilder<List<Party>?>(
                future: getAllParties(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Party> data = snapshot.data!;
                    List<Party> displayedParties = _filterParty(data);
                    return ListViewSeparated(data: displayedParties, buildListItem: _buildItemParty);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Center(
                      child: CircularProgressIndicator()
                  );
                },
              ),
            ),
          )
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
  _updateLesson(Lesson lesson, bool isValid) async {
    //@todo : add one more row to update data on this lesson in DB with a request
    log("Update lesson ${lesson.name} $isValid");
    lesson.isValid = isValid;
    Lesson? removedParty = await lessonUseCase.updateLessonById(lesson);

    if(removedParty !=null){
      _refreshScreen();
    }
  }

  _refreshScreen(){
    Navigator.of(context).build(context); // == kill app
  }

  _updateParty(Party party, bool isValid) async{
    log("Update party ${party.theme} $isValid");
    party.isValid = isValid;
    Party? removedParty = await partyUseCase.updatePartyById(party);

    if(removedParty !=null){
      _refreshScreen();
    }
  }

  /// Return Future [Lesson] list from DB, used in FutureBuilder
  Future<List<Lesson>?> getAllLessons() async {
    return await lessonUseCase.getAllLessons();
  }

  /// Return Future [Party] list from DB, used in FutureBuilder
  Future<List<Party>?> getAllParties() async {
    return await partyUseCase.getAllParties();
  }
  //endregion

  /// Filter [allLessons] depending on [selectedDate] week
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

  /// Filter [allParty] depending on [selectedDate] week
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
