import 'package:flutter/material.dart';
import 'package:my_little_poney/components/background_image.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';

class DailySectionContent extends StatelessWidget {
  const DailySectionContent({Key? key, required this.date, this.resume}) : super(key: key);
  final DateTime date;
  final String? resume;

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.centerLeft,
      child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Row(
              children: [
                Icon(
                  date.compareTo(DateTime.now().getOnlyDate())>=0 ? Icons.school_outlined : Icons.do_not_disturb_on,
                  color: Colors.blue,
                ),
                Container(width: 10,),
                Text("${date.getWeekDayName()}, ${date.day} ${date.getMonthName()}" ),
              ],
            ),
            Text(resume!),
          ]
      ),
    );
  }
}
