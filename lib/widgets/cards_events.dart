import 'package:flutter/material.dart';

class CardsEvents extends Card {

  static Card cardParty(int position, BuildContext context, List<dynamic> listEvents) {
    return Card(
      elevation: 2.0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color.fromRGBO(37, 144, 193, 1.0),
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
                          Icons.celebration,
                          size: 20,
                        ),
                        Text(
                          '${listEvents[position].eventType}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      listEvents[position].isValid
                          ? 'Disponible'
                          : 'Indisponible',
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      '${listEvents[position].theme}',
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
              padding: const EdgeInsets.only(left: 10),
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
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Date: ',
                        style: const TextStyle(fontSize: 10),
                      ),
                      Text('${listEvents[position].partyDateTime}', style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Commentaires: ',
                        style: const TextStyle(fontSize: 10),
                      ),
                      Text('${listEvents[position].attendeesParty.length != 0 ? listEvents[position].attendeesParty.length : 'Pas de commentaies'}', style: const TextStyle(fontSize: 14)),
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

  static Card cardLesson(int position, BuildContext context, List<dynamic> listEvents) {
    return Card(
      elevation: 2.0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color.fromRGBO(222, 68, 68, 1.0),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        child: Row(
          children: [
            SizedBox(
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
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      listEvents[position].isValid
                          ? 'Disponible'
                          : 'Indisponible',
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      '${listEvents[position].ground}',
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      '${listEvents[position].discipline}',
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
              padding: const EdgeInsets.only(left: 10),
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
                        style: const TextStyle(fontSize: 10),
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
                      Text(listEvents[position].duration == 60 ? '1 hour' : '30 minutes', style: const TextStyle(fontSize: 14),)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Date: ',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text('${listEvents[position].lessonDateTime}', style: const TextStyle(fontSize: 14)),
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

  static Card cardContest(int position, BuildContext context, List<dynamic> listEvents) {
    return Card(
      elevation: 2.0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.amber,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        child: Row(
          children: [
            SizedBox(
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
                          Icons.auto_awesome,
                          size: 20,
                        ),
                        Text(
                          '${listEvents[position].eventType}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      listEvents[position].isValid
                          ? 'Disponible'
                          : 'Indisponible',
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
              padding: const EdgeInsets.only(left: 10),
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
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Adresse: ',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text('${listEvents[position].address}', style: const TextStyle(fontSize: 14),)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Date: ',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text('${listEvents[position].contestDateTime}', style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}