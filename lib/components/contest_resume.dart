import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
import 'package:my_little_poney/models/Contest.dart';

class ContestResume extends StatelessWidget {
  const ContestResume({Key? key, required this.contest}) : super(key: key);
  final Contest contest;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text('adress: ${contest.address}'),
            Text('date: ${contest.contestDateTime.getFrenchDateTime()}'),
          ]
      ),
    );
  }
}
