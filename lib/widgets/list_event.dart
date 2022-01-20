import 'package:flutter/material.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/Party.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/contest_usecase.dart';
import 'package:my_little_poney/usecase/lesson_usecase.dart';
import 'package:my_little_poney/usecase/party_usecase.dart';
import 'package:my_little_poney/widgets/cards_events.dart';

class ListEvents extends StatefulWidget {
  const ListEvents({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyListEvents();
}

class MyListEvents extends State<ListEvents> {
  bool isDescending = false;

  late List<dynamic> listEvents;
  String dropdownValue = 'all';

  PartyUseCase partyUseCase = PartyUseCase();
  ContestUseCase contestUseCase = ContestUseCase();
  LessonUseCase lessonUseCase = LessonUseCase();

  _cardsEvents(int position, BuildContext context, List<dynamic> listEvents) {
    var eventPosition = listEvents[position];
    if (eventPosition.runtimeType == Contest) {
      return CardsEvents.cardContest(position, context, eventPosition);
    } else if (eventPosition.runtimeType == Lesson) {
      return CardsEvents.cardLesson(position, context, eventPosition);
    } else if (eventPosition.runtimeType == Party) {
      return CardsEvents.cardParty(position, context, eventPosition);
    }
  }

  Future<List<dynamic>?> _getAllData() async {
    return [await partyUseCase.getAllParties(), await lessonUseCase.getAllLessons(), await contestUseCase.getAllContests()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List events'),
      ),
      body: FutureBuilder<List<dynamic>?>(
        future: _getAllData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
          if (snapshot.hasData) {
            listEvents = snapshot.data!.expand((x) => x).toList();
            return Container(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
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
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                        onPressed: () =>
                            setState(() => isDescending = !isDescending)),
                  ],
                ),
                Expanded(child: listView(context, listEvents))
              ]),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget listView(BuildContext context, List<dynamic> listEvents) {
    if (dropdownValue == 'all') {
      listEvents = listEvents;
    } else if (dropdownValue == 'contest') {
      listEvents = listEvents.where((i) => i.runtimeType == Contest).toList();
    } else if (dropdownValue == 'lesson') {
      listEvents = listEvents.where((i) => i.runtimeType == Lesson).toList();
    } else if (dropdownValue == 'party') {
      listEvents = listEvents.where((i) => i.runtimeType == Party).toList();
    }
    return ListView.builder(
        itemCount: listEvents.length,
        itemBuilder: (context, position) {
          if(listEvents.length > 1){
            final sortedItems = listEvents..sort((a, b) => isDescending
                ? b.name.compareTo(a.name)
                : a.name.compareTo(b.name));
            return Container(child: _cardsEvents(position, context, sortedItems));
          } else{
          }
          return Container(child: _cardsEvents(position, context, listEvents));
        });
  }
}
