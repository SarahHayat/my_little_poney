import 'package:flutter/material.dart';

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
            child:TextButton(
              child: child,
              //style: ElevatedButton.styleFrom(primary: (nbLessons>0 ? Colors.blue[300] : Colors.grey[600])),
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
