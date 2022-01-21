import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_little_poney/models/Lesson.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/lesson_usecase.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';

class LessonView extends StatefulWidget {
  const LessonView({Key? key}) : super(key: key);
  static const tag = "lesson_view";

  @override
  State<LessonView> createState() => _LessonViewState();
}

class _LessonViewState extends State<LessonView> {
  LessonUseCase lessonUseCase = LessonUseCase();
  UserUseCase userUseCase = UserUseCase();
  late Lesson lessonToUpdate;
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
    final arguments = ModalRoute.of(context)?.settings.arguments as Lesson;
    lessonToUpdate = arguments;

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
                  '${arguments.ground}, ${arguments.discipline}',
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
          Text(lessonToUpdate.attendees.length.toString()),
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
        'Le cours de ${arguments.discipline} se déroulera le '
        '${arguments.lessonDateTime} '
        'dans : ${arguments.ground}. '
        'Merci de vous présenter 15 minutes avant le début du cours. ',
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
              selectLessonImg(),
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

  String selectLessonImg() {
    switch (lessonToUpdate.discipline) {
      case 'endurance':
        {
          return 'img/endurance.jpg';
        }
      case 'showJumping':
        {
          return 'img/contest.jpg';
        }
      default:
        {
          return 'img/dressage.jpg';
        }
    }
  }

  Future<void> _shouldJoin(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Souhaitez-vous rejoindre le cours ?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: const Text('Oui'),
                  onPressed: () {
                    _joinLesson();
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

  void _joinLesson() async {
    for (dynamic element in lessonToUpdate.attendees) {
      if (element['user'] == user.id) {
        isSignIn = true;
        break;
      }
    }

    if (!isSignIn) {
      setState(() {
        lessonToUpdate.attendees.add(user.id!);
        lessonUseCase.updateLessonById(lessonToUpdate);
      });
    }

    Navigator.pop(context);
  }
}
