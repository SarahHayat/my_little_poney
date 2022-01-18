import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/gender.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/User.dart';

class HorseList extends StatefulWidget {
  const HorseList({Key? key}) : super(key: key);
  static const tag = "horse_liste";

  @override
  State<HorseList> createState() => _HorseListState();
}

class _HorseListState extends State<HorseList> {
  List<Horse> horses = [Mock.horse, Mock.horse2];
  final User user = Mock.userManagerOwner2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Horses List"),
          elevation: 10,
          centerTitle: true,
        ),
        body: buildListView(horses, _buildRow),
    );
  }

  Widget _buildRow(Horse horse) {
    return ListTile(
      title: Text(
        horse.name
      ),
      subtitle: Container(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text('age: ${horse.age}'),
              Text('dress: ${horse.dress}'),
              Text('race: ${horse.race}'),
              Text('speciality: ${horse.speciality}'),
            ]
          ),
          getGenderIcon(horse.gender)
          ]
        )
      ),
      trailing: _buildDeleteButton(horse),
    );

  }

  _buildDeleteButton(Horse horse){
    return user.role == UserRole.manager
        ? TextButton(
            onPressed: (){
              dialogue(horse);
            },
            child: Icon(Icons.delete_forever, color: Colors.red,),
          )
        : Container();
  }

  _removeHorse(Horse horse){
    setState(() {
      horses.remove(horse);
    });
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
                  _confirmDeletionButton(true, horse, context),
                  _confirmDeletionButton(false, horse, context),
                ],
              ),
            ],
          );
        }
    );
  }

  ElevatedButton _confirmDeletionButton (bool confirm, Horse horse, BuildContext context){
    return ElevatedButton(
      onPressed: (){
        Navigator.pop(context);
        if(confirm){
          _removeHorse(horse);
        }
      },
      child: Text(confirm ? "Yes" : "No"),
    );
  }
}



