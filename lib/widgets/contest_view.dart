import 'package:flutter/material.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/helper/temporaryContest.dart';
import 'package:my_little_poney/usecase/contest_usecase.dart';

class ContestView extends StatefulWidget {
  const ContestView({Key? key}) : super(key: key);
  static const tag = "contest_view";

  @override
  State<ContestView> createState() => _ContestViewState();
}

class _ContestViewState extends State<ContestView> {
  String levelValue = Level.amateur.name;
  ContestUseCase contestUseCase = ContestUseCase();
  late Contest contestToUpdate;

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
        _buildButtonColumn(color, Icons.join_inner, 'Participer'),
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
        ),
        body: ListView(
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
              _joinContestDialog(context);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _joinContestDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Voulez-vous participer au concours ?'),
            content: Card(
              elevation: 5,
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    boutonBool(true),
                    boutonBool(false),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _selectLevel(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
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
  }

  ElevatedButton boutonBool(bool b) {
    return ElevatedButton(
      onPressed: (() => (b) ? _selectLevel(context) : Navigator.pop(context)),
      child: Text((b) ? "Oui" : "Non"),
    );
  }

  void _joinContest() async {
    AttendeeContest newAttendee =
        AttendeeContest(user: monUser.id.toString(), level: levelValue);

    setState(() {
      contestToUpdate.attendeesContest.add(newAttendee);
    });

    Future<Contest?> updatedContest =
        contestUseCase.updateContestById(contestToUpdate);

    Navigator.pop(context);
  }
}
