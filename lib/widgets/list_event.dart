import 'package:flutter/material.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/Event.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/Party.dart';
import 'package:my_little_poney/models/User.dart';

class ListEvents extends StatefulWidget {
  const ListEvents({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyListEvents();
}

class MyListEvents extends State<ListEvents> {
  bool isDescending = false;

  static User userManagerOwner = User(
    "id1",
    "profilePicture",
    20,
    "FFELink",
    "phoneNumber",
    UserRole.manager,
    [],
    DateTime.now(),
    Type.owner,
    userName: "Antony",
    password: "12345",
    email: "antony@gmail.com",
  );

  static Horse horse = Horse(
    [],
    "id1",
    name: "Etoile d'argent",
    age: 2,
    picturePath: "picturePath",
    dress: "dress",
    race: HorseRace.appaloosa,
    gender: Gender.other,
    speciality: Speciality.endurance,
    owner: userManagerOwner,
    createdAt: DateTime.now(),
  );

  static User userRiderDp = User(
    "id2",
    "profilePicture",
    20,
    "FFELink",
    "phoneNumber",
    UserRole.rider,
    [horse],
    DateTime.now(),
    Type.dp,
    userName: "Jojo",
    password: "12345",
    email: "antony@gmail.com",
  );

  static Party party = Party(
    "id1",
    'd',
    "picturePath",
    [AttendeeParty("Des chips !", user: userManagerOwner)],
    user: userRiderDp,
    theme: Themes.happyHour,
    createdAt: DateTime.now(),
  );
  static Party party1 = Party("id2", 'e', "picturePath",
      [AttendeeParty("Des chips !", user: userManagerOwner)],
      user: userRiderDp,
      theme: Themes.happyHour,
      createdAt: DateTime.now(),
      isValid: true);

  static Lesson lesson = Lesson("id1", [],
      name: "c",
      user: userManagerOwner,
      ground: Ground.carousel,
      lessonDateTime: DateTime.now(),
      createdAt: DateTime.now(),
      duration: 30,
      discipline: Discipline.endurance);

  static Contest contest = Contest(
    "id1",
    [AttendeeContest(user: userManagerOwner, level: Level.amateur)],
    user: userRiderDp,
    name: "azeagiuazyeiuazieakeyiazyueyuieayzeizayiaezuiueziauyeazeuiyazuieyazieyazuie eaz eaz eaz eaz e zae az e a e a ea e az eza e ",
    address: "address",
    picturePath: "picturePath",
    contestDateTime: DateTime.now(),
    createdAt: DateTime.now(),
  );

  static Contest contest1 = Contest(
    "id2",
    [],
    user: userRiderDp,
    name: "b",
    address: "address",
    picturePath: "picturePath",
    contestDateTime: DateTime.now(),
    createdAt: DateTime.now(),
  );

  List<dynamic> listEvents = [contest, lesson, party, party1, contest1];
  String dropdownValue = 'all';

  _cardsEvents(int position, BuildContext context, List<dynamic> listEvents) {
    var eventPosition = listEvents[position];

    if (eventPosition.eventType == 'contest') {
      return cardContest(position, context, listEvents);
    } else if (eventPosition.eventType == 'lesson') {
      return cardLesson(position, context, listEvents);
    } else if (eventPosition.eventType == 'party') {
      return cardParty(position, context, listEvents);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List events'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(5),
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  items: <String>['all', 'contest', 'lesson', 'party']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ),
              TextButton.icon(
                  icon: Icon(
                    Icons.sort_rounded,
                    size: 28,
                    color: Colors.black,
                  ),
                  label: Text(
                    isDescending ? 'Desc' : 'Asc',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  onPressed: () =>
                      setState(() => isDescending = !isDescending)),
            ],
          ),
          Expanded(child: listView(context, listEvents))
        ]),
      ),
    );
  }

  Widget listView(BuildContext context, List<dynamic> listEvents) {
    if (dropdownValue == 'all') {
      listEvents = listEvents;
    } else if (dropdownValue == 'contest') {
      listEvents = listEvents.where((i) => i.eventType == 'contest').toList();
    } else if (dropdownValue == 'lesson') {
      listEvents = listEvents.where((i) => i.eventType == 'lesson').toList();
    } else if (dropdownValue == 'party') {
      listEvents = listEvents.where((i) => i.eventType == 'party').toList();
    }
    return ListView.builder(
        itemCount: listEvents.length,
        itemBuilder: (context, position) {
          final sortedItems = listEvents
            ..sort((a, b) => isDescending
                ? b.name.compareTo(a.name)
                : a.name.compareTo(b.name));
          return Container(child: _cardsEvents(position, context, sortedItems));
        });
  }

  Card cardParty(int position, BuildContext context, List<dynamic> listEvents) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          children: [
            Text(
              listEvents[position].name,
            ),
            Text('Created by : ${listEvents[position].user.userName}'),
            Text(listEvents[position].isValid ? 'Disponible' : 'Indisponible'),
            Text('Tag : ${listEvents[position].eventType}')
          ],
        ),
      ),
    );
  }

  Card cardLesson(
      int position, BuildContext context, List<dynamic> listEvents) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          children: [
            Text(listEvents[position].name),
            Text('Created by : ${listEvents[position].user.userName}'),
            Text(
                'For: ${listEvents[position].duration == 60 ? '1 hour' : '30 minutes'} at ${listEvents[position].lessonDateTime}'),
            Text('Discipline: ${listEvents[position].discipline}'),
            Text('Ground: ${listEvents[position].ground}'),
            Text('Tag: ${listEvents[position].eventType}'),
          ],
        ),
      ),
    );
  }

  Card cardContest(
      int position, BuildContext context, List<dynamic> listEvents) {
    return Card(
      elevation: 2.0,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white)),
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    listEvents[position].name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Column(
                  children: [
                    Text('Tag: ${listEvents[position].eventType}'),
                    Text(listEvents[position].isValid
                        ? 'Disponible'
                        : 'Indisponible'),
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Text('Created by : ${listEvents[position].user.userName}'),
            Text(
                'The contest begin at : ${listEvents[position].contestDateTime}'),
            Text('Address: ${listEvents[position].address}'),
            Text(
                'For levels : ${listEvents[position].attendeesContest.length != 0 ? listEvents[position].attendeesContest[0].level : 'No levels required'}'),
          ],
        ),
      ),
    );
  }
}
