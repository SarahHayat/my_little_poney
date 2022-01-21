import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
import 'package:my_little_poney/models/Party.dart';
import 'package:my_little_poney/components/text_icon.dart';

class PartyTile extends StatelessWidget {
  const PartyTile({Key? key, required this.party, this.onTap}) : super(key: key);
  final Party party;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
          child: Row(
            children: [
              Text(party.theme)
              //TextIcon(title: party.theme, icon: party.theme.getIcon(), ),
            ],
          )
      ),
      subtitle: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text('host: ${party.partyDateTime.getFrenchDate()}'),
              Text('theme: ${party.theme}'),
              TextIcon(title: "accepted: ", icon:Icon(party.isValid ? Icons.check : Icons.do_not_disturb_on) ),
            ]
        ),
      ),
      //trailing: Image.network('${party.picturePath}'),
      onTap: (){
        onTap!();
      },
    );
  }
}
