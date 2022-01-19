import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/view/confirm_deletion_button.dart';

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
  late List<Horse> horses ;
  final User user = Mock.userManagerOwner;

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
        body: ListViewSeparated(data: horses,buildRow: _buildRow),
    );
  }

  Widget _buildRow(Horse horse) {
    return ListTile(
      title: Container(
        child: Row(
          children: [
            Text( horse.name ),
            horse.gender.getGenderIcon()
          ],
        )
      ),
      subtitle: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text('age: ${horse.age}'),
            Text('dress: ${horse.dress}'),
            Text('race: ${horse.race.toShortString()}'),
            Text('speciality: ${horse.speciality.toShortString()}'),
          ]
        ),
      ),
      trailing: _buildDeleteButton(horse),
    );
  }

  _buildDeleteButton(Horse horse){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [user.isManager()
          ? ElevatedButton(
        onPressed: (){
          dialogue(horse);
        },
        child: Icon(Icons.delete_forever, color: Colors.red,),
        style: ElevatedButton.styleFrom(primary: Colors.white),
      )
          : Container(width: 0,)
    ]
    );
  }

  Future<Null> dialogue(Horse horse) async{
    //double taille = MediaQuery.of(context).size.width *0.75;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            title: Text("Delete this horse?"),
            contentPadding: EdgeInsets.all(20.0),
            children: [
              Text("${horse.name} will be deleted forever."),
              Text("Are you sure you want to delete it?"),
              Container(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ConfirmDeletionButton(true, context, trueFunction: ()=>_removeHorse(horse),),
                  ConfirmDeletionButton(false, context),
                ],
              ),
            ],
          );
        }
    );
  }

  _getHorses(){
    //@todo : use request here to get horses list from DB
    setState(() {
      horses = [Mock.horse, Mock.horse2];
    });
  }

  _removeHorse(Horse horse){
    //@todo : add one more row to delete horse in DB with a request
    // all user related to this horse should removed it from their horses list
    setState(() {
      horses.remove(horse);
    });
  }


}



