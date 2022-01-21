import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';

class DailySection extends StatelessWidget {
  const DailySection({Key? key, required this.date, required this.child, this.onPressed}) : super(key: key);
  final DateTime date;
  final Widget child;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child:Container(
            decoration:BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                Colors.white,
                date.getWeekDayColor(),
                ],
              ),
            ),
            child:TextButton(
              child: child,
              onPressed: (){
                if(onPressed is Function) {
                  onPressed!();
                }
              },
            )
        )
    );
  }
}
