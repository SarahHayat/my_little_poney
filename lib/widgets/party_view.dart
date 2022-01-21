import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_little_poney/models/Party.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/party_usecase.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';

class PartyView extends StatefulWidget {
  const PartyView({Key? key}) : super(key: key);
  static const tag = "party_view";

  @override
  State<PartyView> createState() => _PartyViewState();
}

class _PartyViewState extends State<PartyView> {
  PartyUseCase partyUseCase = PartyUseCase();
  UserUseCase userUseCase = UserUseCase();
  late Party partyToUpdate;
  final LocalStorage storage = LocalStorage('poney_app');
  late User user;
  bool isSignIn = false;
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    user = User.fromJson(storage.getItem('user'));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Party;
    partyToUpdate = arguments;

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
                  '${arguments.theme}',
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
          Text(partyToUpdate.attendeesParty.length.toString()),
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
        'La soirée ayant pour thème : ${arguments.theme} se déroulera le '
        '${arguments.partyDateTime} '
        'dans le club house de l\'écurie. '
        'Veuillez laisser un message avec ce que vous comptez ramener si '
        'vous souhaitez vous joindre à nous. ',
        softWrap: true,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(arguments.name),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          children: [
            Image.asset(
              selectPartyImg(),
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
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
              _shouldJoin(context);
            },
          ),
        ),
      ],
    );
  }

  String selectPartyImg() {
    switch (partyToUpdate.theme) {
      case 'happyHour':
        {
          return 'img/apero.jpg';
        }
      default:
        {
          return 'img/dinner.jpg';
        }
    }
  }

  Future<void> _shouldJoin(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Souhaitez-vous rejoindre la soirée ?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: const Text('Oui'),
                  onPressed: () {
                    _joinParty();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: const Text('Non'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
        });
  }

  void _joinParty() async {
    for (dynamic element in partyToUpdate.attendeesParty) {
      if (element['user'] == user.id) {
        isSignIn = true;
        break;
      }
    }

    if (!isSignIn) {
      setState(() {
        partyToUpdate.attendeesParty.add(user.id!);
        partyUseCase.updatePartyById(partyToUpdate);
      });
    }

    Navigator.pop(context);
  }
}
