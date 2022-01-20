import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/horse_usecase.dart';
import 'package:my_little_poney/view/component/horse_tile.dart';

import 'component/delete_button.dart';
import 'component/yes_no_dialog.dart';

//@todo : Icon Navigation for Contest : emoji_events_outlined or event_note_sharp;
//  for party : festival, free_breakfast, liquor_sharp,localbar, night_life_sharp
// for lesson : local_library, school_sharp
// for profile : manage_account
//for stable (horse liste) : gite


class HorsesList extends StatefulWidget {
  const HorsesList({Key? key}) : super(key: key);
  static const tag = "horses_liste";

  @override
  State<HorsesList> createState() => _HorsesListState();
}

class _HorsesListState extends State<HorsesList> {
  final HorseUseCase horseCase = HorseUseCase();
  late Future<List<Horse>> horses ;
  final User currentUser = Mock.userManagerOwner;

  @override
  void initState() {
    super.initState();
    _getHorses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Horses List"),
          elevation: 10,
          centerTitle: true,
        ),
        body: FutureBuilder<List<Horse>>(
          future: horses,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Horse> data = snapshot.data!;
                return ListViewSeparated(data: data,buildListItem: _buildRow);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(
                  child: CircularProgressIndicator()
              );
            },
          )
        ,
    );
  }

  /// Create a [HorseTile] containing his information.
  /// A [DeleteButton] could be added to the right, that will display
  /// a dialog to confirm deletion.
  Widget _buildRow(Horse horse) {
    return HorseTile(
      horse: horse,
      trailing: DeleteButton(
        display: currentUser.isManager(),
        onPressed: (){
          dialogue(horse);
        },
      )
    );
  }

  /// Display a dialog to delete the [horse].
  Future<Null> dialogue(Horse horse) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return YesNoDialog(
            title: "Delete this horse?",
            children: [
              Text("${horse.name} will be deleted forever."),
              Text("Are you sure you want to delete it?"),
            ],
            trueFunction: ()=>_removeHorse(horse),
          );
        }
    );
  }

  _getHorses() async {
    //@todo : use request here to get horses list from DB
    Future<List<Horse>> resHorses =  horseCase.getAllHorses();
    log(resHorses.toString());
    setState(() {
      horses = resHorses;
    });
  }

  _removeHorse(Horse horse){
    //@todo : add one more row to delete horse in DB with a request
    // all user related to this horse should removed it from their horses list
    setState(() {
      //horses.remove(horse);
    });
  }
}



