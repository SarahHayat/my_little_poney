import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/view/confirm_deletion_button.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);
  static const tag = "users_liste";

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late List<User> users ;
  final User currentUser = Mock.userManagerOwner2;

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
        elevation: 10,
        centerTitle: true,
      ),
      body: buildListView(users, _buildRow),
    );
  }

  Widget _buildRow(User user) {
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
      trailing: _buildDeleteButton(user),
    );
  }

  _buildDeleteButton(User user){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [!user.isManager() && currentUser.isManager()
            ? ElevatedButton(
          onPressed: (){
            dialogue(user);
          },
          child: Icon(Icons.delete_forever, color: Colors.red,),
          style: ElevatedButton.styleFrom(primary: Colors.white),
        )
            : Container(width: 0,)
        ]
    );
  }

  Future<Null> dialogue(User user) async{
    //double taille = MediaQuery.of(context).size.width *0.75;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            title: Text("Delete this user?"),
            contentPadding: EdgeInsets.all(20.0),
            children: [
              Text("${user.userName} will be deleted forever."),
              Text("Are you sure you want to delete it?"),
              Container(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ConfirmDeletionButton(true, context, trueFunction: ()=>_removeUser(user),),
                  ConfirmDeletionButton(false, context),
                ],
              ),
            ],
          );
        }
    );
  }

  _getUsers(){
    //@todo : use request here to get users list from DB
    setState(() {
      users = [Mock.userRiderDp2, Mock.userManagerOwner2];
    });
  }

  _removeUser(User user){
    //@todo : add one more row to delete user in DB with a request
    // + all horses related to this user should be removed if he is an owner
    // else, all horse related to this user should removed it from their user list
    // you can use user.isOwner() if needed for the request
    setState(() {
      users.remove(user);
    });
  }


}



