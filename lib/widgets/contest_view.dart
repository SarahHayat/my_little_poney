import 'package:flutter/material.dart';
import 'package:my_little_poney/models/Contest.dart';

class ContestView extends StatefulWidget {
  const ContestView({Key? key}) : super(key: key);
  static const tag = "contest_view";

  @override
  State<ContestView> createState() => _ContestViewState();
}

class _ContestViewState extends State<ContestView> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Contest;

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
          Text(arguments.attendeesContest.length.toString()),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.join_inner, 'Rejoindre'),
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
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
