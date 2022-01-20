import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/list_extension.dart';
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
  final List<Horse> removedHorses = [];
  final User currentUser = Mock.userManagerOwner;

  @override
  void initState() {
    super.initState();
    _getHorses();
  }

  @override
  Widget build(BuildContext context) {
    horseCase.createHorse(Mock.horse);
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
                data.removeFromArray(removedHorses);
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

  /// Set [horses] to the new
  _getHorses() async {
    Future<List<Horse>> resHorses =  horseCase.getAllHorses();
    log(resHorses.toString());
    setState(() {
      horses = resHorses;
    });
  }

  _removeHorse(Horse horse) async {
    //@todo : add one more row to delete horse in DB with a request
    // all user related to this horse should removed it from their horses list


    //[log] Instance of 'Future<List<Horse>>'
    // [ERROR:flutter/lib/ui/ui_dart_state.cc(209)] Unhandled Exception: Null check operator used on a null value
    // #0      _HorsesListState._removeHorse (package:my_little_poney/view/horses_list.dart:120:21)
    // <asynchronous suspension>
    //
    // [log] 200
    // [log] {"_id":"61e8877effa82f1606d4756c","dpUsers":[],"createdAt":"2022-01-19T21:49:50.263Z",
    // "owner":"61e88761ffa82f1606d47565","speciality":"endurance","gender":"male","race":"mustang",
    // "dress":"dress","picturePath":"picturePath","age":2,"name":"étoile d'argent","__v":0}

    Horse? removedHorse = await horseCase.deleteHorseById(horse.id);
    if(removedHorse !=null){
      setState(() {
        removedHorses.add(horse);
      });
    }
  }
}



