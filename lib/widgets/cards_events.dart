import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/Party.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';

class CardsEvents extends Card {
  UserUseCase userCase = UserUseCase();
  late Future<User> user;

  Future<User> _getUserByid(String? id) async {
    user = userCase.fetchUserById(id);
    return user;
  }

  _dateTimeFormat(DateTime dateTime){
    return DateFormat('yyyy-MM-dd - HH:mm').format(dateTime);
  }

  RichText _remainingTime(DateTime dateTime){
    String timeRemain = dateTime.difference(DateTime.now()).toString().split('.')[0];
    int hours = int.parse(timeRemain.split(':')[0]);
    int minutes = int.parse(timeRemain.split(':')[1]);
    int seconds = int.parse(timeRemain.split(':')[2]);
    if(hours == 0){
      if(minutes == 0){
        return RichText(
          text: TextSpan(
              style: const TextStyle(
                fontSize: 10.0,
                color: Colors.black,
              ),
            children: <TextSpan>[
              TextSpan(text:'depuis '),
              TextSpan(text:'$seconds s', style: const TextStyle(fontWeight: FontWeight.bold))
            ]
          ),
        );
      } else {
        return RichText(
          text: TextSpan(
              style: const TextStyle(
                fontSize: 10.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(text:'depuis '),
                TextSpan(text:'$minutes min', style: const TextStyle(fontWeight: FontWeight.bold))
              ]
          ),
        );
      }
    } else {
      return RichText(
        text: TextSpan(
            style: const TextStyle(
              fontSize: 10.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(text:'depuis '),
              TextSpan(text:'${hours.toString().split('-')[1]} h', style: const TextStyle(fontWeight: FontWeight.bold))
            ]
        ),
      );
    }
  }

  FutureBuilder<User?> cardParty(int position, BuildContext context, Party listEvents) {
    String? userParty;
    String? userComment;
    return FutureBuilder<User?>(
      future: _getUserByid(listEvents.user),
      builder: (context, snapshot){
        if(snapshot.hasData){
          userParty = snapshot.data?.userName;
          Map<String, dynamic> mapAttendees = listEvents.attendeesParty?[0];
          userComment = mapAttendees['comment'];
        }else{
          userParty = '...loading';
        }
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.celebration,
                              size: 20,
                            ),
                            Text(
                              'Party',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          listEvents.isValid
                              ? 'Disponible'
                              : 'Indisponible',
                          style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          listEvents.theme,
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
                          Text(listEvents.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                              overflow: TextOverflow.ellipsis),
                          Text(
                            'Créer par : $userParty',
                            style: const TextStyle(fontSize: 10),
                          ),
                          _remainingTime(listEvents.createdAt),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Date: ',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(_dateTimeFormat(listEvents.partyDateTime), style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Commentaires: ',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text('${listEvents.attendeesParty?.length != 0 ? listEvents.attendeesParty?.length : 'Pas de commentaires'}', style: const TextStyle(fontSize: 14)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  FutureBuilder<User?> cardLesson(int position, BuildContext context, Lesson listEvents) {
    String? userLesson;
    return FutureBuilder<User?>(
      future: _getUserByid(listEvents.user),
      builder: (context, snapshot){
        if(snapshot.hasData){
          userLesson = snapshot.data?.userName;
        }else{
          userLesson  = '...loading';
        }
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
                          children: const [
                            Icon(
                              Icons.book,
                              size: 20,
                            ),
                            Text(
                              'Lesson',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          listEvents.isValid
                              ? 'Disponible'
                              : 'Indisponible',
                          style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          listEvents.ground,
                          style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          listEvents.discipline,
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
                          Text(listEvents.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                              overflow: TextOverflow.ellipsis),
                          Text(
                            'Créer par : $userLesson',
                            style: const TextStyle(fontSize: 10),
                          ),
                          _remainingTime(listEvents.createdAt),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Durée: ',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(listEvents.duration == 60 ? '1 hour' : '30 minutes', style: const TextStyle(fontSize: 14),)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Date: ',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text('${_dateTimeFormat(listEvents.lessonDateTime)}', style: const TextStyle(fontSize: 14)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  FutureBuilder<User?> cardContest(int position, BuildContext context, Contest listEvents) {
    String? userContest;
    String? userAttendeesContestLevel;
    Map<String, dynamic> mapAttendees;
    return FutureBuilder<User?>(
      future: _getUserByid(listEvents.user),
      builder: (context, snapshot){
        if(snapshot.hasData){
          userContest = snapshot.data?.userName;
        } else{
          userContest = '...loading';
        }
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
                          children: const [
                            Icon(
                              Icons.auto_awesome,
                              size: 20,
                            ),
                            Text(
                              'Contest',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          listEvents.isValid
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
                          Text(listEvents.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                              overflow: TextOverflow.ellipsis),
                          Text(
                            'Créer par : $userContest',
                            style: const TextStyle(fontSize: 10),
                          ),
                          _remainingTime(listEvents.createdAt!),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Adresse: ',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(listEvents.address, style: const TextStyle(fontSize: 14),)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Date: ',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text('${_dateTimeFormat(listEvents.contestDateTime)}', style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Card cardUsers(int position, BuildContext context, User listEvents){
    return Card(
      elevation: 2.0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color.fromRGBO(118, 170, 32, 1.0),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.account_circle,
                          size: 20,
                        ),
                        Text(
                          'User',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      '${listEvents.type}',
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      '${listEvents.role}',
                      style:
                      const TextStyle(fontSize: 10),
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
                      Text(listEvents.userName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                          overflow: TextOverflow.ellipsis),
                      _remainingTime(listEvents.createdAt!),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(listEvents.profilePicture!),
                          onBackgroundImageError: (error, stack){
                            error.toString();
                          },
                        )
                      ),
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