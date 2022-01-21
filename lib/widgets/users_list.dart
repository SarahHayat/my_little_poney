import 'package:flutter/material.dart';
import 'package:my_little_poney/components/background_image.dart';
import 'package:my_little_poney/components/yes_no_dialog.dart';
import 'package:my_little_poney/helper/list_extension.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';
import 'package:my_little_poney/components/delete_button.dart';
import 'package:my_little_poney/components/user_tile.dart';


class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);
  static const tag = "users_liste";

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final UserUseCase userCase = UserUseCase();
  late Future<List<User>> users ;
  final List<User> removedUsers = [];
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
        body: Container(
          decoration: BackgroundImageDecoration("https://images.sudouest.fr/2014/09/19/57ebc40466a4bd6726a540d5/golden/1200x750/de-gauche-a-droite.jpg"),
          child: FutureBuilder<List<User>>(
            future: users,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<User> data = snapshot.data!;
                data.removeFromArray(removedUsers);
                return ListViewSeparated(data: data,buildListItem: _buildRow);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(
                  child: CircularProgressIndicator()
              );
            },
          )
        ),
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
    Future<List<User>> resUser = userCase.getAllUser();
    setState(() {
      users = resUser;
    });
  }

  _removeUser(User user) async {
    //@todo : add one more row to delete user in DB with a request
    // + all horses related to this user should be removed if he is an owner
    // else, all horse related to this user should removed it from their user list
    // you can use user.isOwner() if needed for the request
    User? removedUser = await userCase.deleteUserById(user.id);
    if(removedUser !=null){
      setState(() {
        removedUsers.add(user);
      });
    }
  }
}



