import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_little_poney/components/delete_button.dart';
import 'package:my_little_poney/components/user_tile.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/contest_usecase.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';

class ContestView extends StatefulWidget {
  const ContestView({Key? key}) : super(key: key);
  static const tag = "contest_view";

  @override
  State<ContestView> createState() => _ContestViewState();
}

class _ContestViewState extends State<ContestView> {
  String levelValue = Level.amateur.name;
  ContestUseCase contestUseCase = ContestUseCase();
  UserUseCase userUseCase = UserUseCase();
  late Contest contestToUpdate;
  final LocalStorage storage = LocalStorage('poney_app');
  late User currentUser;
  bool isSignIn = false;
  late List<User> resUsers;

  @override
  void initState() {
    super.initState();
    currentUser = User.fromJson(storage.getItem('user'));

  }

  Future<List<User>> _getUsers(List<dynamic> attendeesContest) async {
    List<String> ids = [];
    for (dynamic element in attendeesContest) {
       ids.add(element['user']);
    }

    Future<List<User>> res =  userUseCase.fetchUsersByIds(ids);
    return await res;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Contest;
    contestToUpdate = arguments;

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    arguments.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  arguments.address,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.person,
            color: Colors.red[500],
          ),
          Text(contestToUpdate.attendeesContest.length.toString()),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.group_add, 'Participer'),
      ],
    );

    Widget textSection = Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Le concours se déroulera le '
        '${arguments.contestDateTime} '
        'a l\'addresse : ${arguments.address}. '
        'Merci de vous présenter une heure avant le début du concours. ',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Concours d\'équitation',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Concours d\'équitation'),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            Image.asset(
              'img/contest.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
            FutureBuilder<List<User>>(
                future: _getUsers(contestToUpdate.attendeesContest),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    resUsers = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: resUsers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(resUsers[index].profilePicture!, width: 150,),
                                Text(resUsers[index].userName)
                              ],
                            );
                      },);
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.white),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
            onPressed: () {
              _selectLevel(context);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _selectLevel(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Choisissez un niveau ?'),
              content: Card(
                elevation: 5,
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButton<String>(
                    value: levelValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        levelValue = newValue!;
                      });
                    },
                    items:
                    Level.values.map<DropdownMenuItem<String>>((Level value) {
                      return DropdownMenuItem<String>(
                        value: value.name,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: const Text('Ok'),
                  onPressed: () {
                    _joinContest();
                  },
                ),
              ],
            );
          });

        });
  }

  Widget _buildRow(User user) {
    return UserTile(
        user: user,
        trailing: DeleteButton(
          display: !user.isManager() && currentUser.isManager(),
          onPressed: (){
            // dialogue(user);
          },
        )
    );
  }

  void _joinContest() async {

    AttendeeContest newAttendee =
        AttendeeContest(user: currentUser.id!, level: levelValue);



    for(dynamic element in contestToUpdate.attendeesContest) {
      if(element['user'] == currentUser.id) {
        isSignIn = true;
        break;
      }
    }

    if (!isSignIn) {
      setState(() {
        contestToUpdate.attendeesContest.add(newAttendee);
        contestUseCase.updateContestById(contestToUpdate);
      });
    }

    Navigator.pop(context);
  }
}
