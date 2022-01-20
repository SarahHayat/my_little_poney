import 'package:flutter/material.dart';
import 'package:my_little_poney/models/User.dart';

class UserTile extends StatelessWidget {
  const UserTile({Key? key, required this.user, this.trailing}) : super(key: key);
  final User user;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
          child: Row(
            children: [
              Text( user.userName ),
              user.role.getRoleIcon()
            ],
          )
      ),
      subtitle: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text('age: ${user.age}'),
              Text('type: ${user.type.toShortString()}'),
              Text('phone: ${user.phoneNumber}'),
              Text('email: ${user.email}'),
              Text('profil FFE: ${user.FFELink}'),
            ]
        ),
      ),
      trailing: trailing,
    );
  }
}
