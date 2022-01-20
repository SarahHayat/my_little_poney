import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/view/component/delete_button.dart';
import 'package:my_little_poney/view/component/user_tile.dart';
import 'package:my_little_poney/view/component/yes_no_dialog.dart';

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
      body: ListViewSeparated(data: users,buildListItem: _buildRow),
    );
  }

  /// Create a [UserTile] containing his information.
  /// A [DeleteButton] could be added to the right, that will display
  /// a dialog to confirm deletion.
  Widget _buildRow(User user) {
    return UserTile(
      user: user,
      trailing: DeleteButton(
        display: !user.isManager() && currentUser.isManager(),
        onPressed: (){
          dialogue(user);
        },
      )
    );
  }

  /// Display a dialog to delete the [user].
  Future<Null> dialogue(User user) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return YesNoDialog(
              title: "Delete this user?",
              children: [
                Text("${user.userName} will be deleted forever."),
                Text("Are you sure you want to delete it?"),
              ],
            trueFunction: ()=>_removeUser(user),
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



