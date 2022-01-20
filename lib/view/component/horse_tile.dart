import 'package:flutter/material.dart';
import 'package:my_little_poney/models/Horse.dart';

class HorseTile extends StatelessWidget {
  const HorseTile({Key? key, required this.horse, this.trailing}) : super(key: key);
  final Horse horse;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
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
      trailing: trailing,
    );
  }
}
