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
    partyDateTime: DateTime.now(),
  );
  static Party party1 = Party("id2", 'e', "picturePath",
      [AttendeeParty("Des chips !", user: userManagerOwner)],
      user: userRiderDp,
      theme: Themes.happyHour,
      createdAt: DateTime.now(),
      partyDateTime: DateTime.now(),
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
    [
      AttendeeContest(
        user: userManagerOwner,
        level: Level.amateur,
      )
    ],
    user: userRiderDp,
    name:
        "azeagiuazyeiuazieakeyiazyueyuieayzeizayiaezuiueziauyeazeuiyazuieyazieyazuie eaz eaz eaz eaz e zae az e a e a ea e az eza e ",
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
          final sortedItems = listEvents..sort((a, b) => isDescending
                ? b.name.compareTo(a.name)
                : a.name.compareTo(b.name));
          return Container(child: _cardsEvents(position, context, sortedItems));
        });
  }

  Card cardParty(int position, BuildContext context, List<dynamic> listEvents) {
    return Card(
      elevation: 2.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.red,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.celebration,
                          size: 20,
                        ),
                        Text(
                          '${listEvents[position].eventType}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      listEvents[position].isValid
                          ? 'Disponible'
                          : 'Indisponible',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      '${listEvents[position].theme}',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: VerticalDivider(
                color: Colors.black,
                thickness: 0.5,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.60,
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listEvents[position].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                          overflow: TextOverflow.ellipsis),
                      Text(
                        'Créer par : ${listEvents[position].user.userName}',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text('${listEvents[position].partyDateTime}', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Commentaires: ',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text('à faire', style: TextStyle(fontSize: 14)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  /*
  Text('Created by : ${listEvents[position].user.userName}'),
  Text(listEvents[position].isValid ? 'Disponible' : 'Indisponible'),
  Text('Tag : ${listEvents[position].eventType}')
*/
  Card cardLesson(
      int position, BuildContext context, List<dynamic> listEvents) {
    return Card(
      elevation: 2.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.teal,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.book,
                          size: 20,
                        ),
                        Text(
                          '${listEvents[position].eventType}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      listEvents[position].isValid
                          ? 'Disponible'
                          : 'Indisponible',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      '${listEvents[position].ground}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      '${listEvents[position].discipline}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: VerticalDivider(
                color: Colors.black,
                thickness: 0.5,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.60,
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listEvents[position].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                          overflow: TextOverflow.ellipsis),
                      Text(
                        'Créer par : ${listEvents[position].user.userName}',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Durée: ',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(listEvents[position].duration == 60 ? '1 hour' : '30 minutes', style: TextStyle(fontSize: 14),)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text('${listEvents[position].lessonDateTime}', style: TextStyle(fontSize: 14)),
                    ],
                  )
                ],
              ),
            ),
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Icon(Icons.celebration),
                      Text(listEvents[position].eventType),
                    ],
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Organisateur :',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(listEvents[position].user.userName)
                  ],
                ),
                Text(listEvents[position].isValid
                    ? 'Disponible'
                    : 'Indisponible'),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date du concours :',
                  style: TextStyle(fontSize: 10),
                ),
                Text('${listEvents[position].contestDateTime}')
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adresse :',
                  style: TextStyle(fontSize: 10),
                ),
                Text('${listEvents[position].address}')
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pour les niveaux :',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                    ' ${listEvents[position].attendeesContest.length != 0 ? listEvents[position].attendeesContest[0].level : 'No levels required'}')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
