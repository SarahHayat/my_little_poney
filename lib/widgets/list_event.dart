import 'package:flutter/material.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/Party.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/widgets/cards_events.dart';

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
      return CardsEvents.cardContest(position, context, listEvents);
    } else if (eventPosition.eventType == 'lesson') {
      return CardsEvents.cardLesson(position, context, listEvents);
    } else if (eventPosition.eventType == 'party') {
      return CardsEvents.cardParty(position, context, listEvents);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List events'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(5),
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
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
                  icon: const Icon(
                    Icons.sort_rounded,
                    size: 28,
                    color: Colors.black,
                  ),
                  label: Text(
                    isDescending ? 'Desc' : 'Asc',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
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
}
