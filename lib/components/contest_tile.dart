import 'package:flutter/material.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/components/contest_resume.dart';

class ContestTile extends StatelessWidget {
  const ContestTile({Key? key, required this.contest, this.onTap}) : super(key: key);
  final Contest contest;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: (){
          onTap!();
        },
        title: Container(
          child:Text( "${contest.name} - ${contest.address}" ),
        ),
        subtitle: ContestResume(contest: contest,)
    );
  }
}
