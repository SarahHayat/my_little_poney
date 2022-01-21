import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/models/Lesson.dart';
import '../models/User.dart';
import 'lesson_view.dart';
import 'package:intl/intl.dart';
import 'package:my_little_poney/usecase/lesson_usecase.dart';

class LessonListView extends StatefulWidget {
  const LessonListView({Key? key, required this.title}) : super(key: key);
  static const tag = "lesson_view_list";

  final String title;

  @override
  State<LessonListView> createState() => _LessonListState();
}

class _LessonListState extends State<LessonListView> {
  LessonUseCase lessonUseCase = LessonUseCase();
  final LocalStorage storage = LocalStorage('poney_app');
  late User user;

  late List<Lesson>? lessons;

  late Lesson newLesson;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String groundValue = Ground.carousel.name;
  String disciplineValue = Discipline.dressage.name;
  int durationValue = 30;

  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    getAllLessonsFromDb();
    super.initState();
  }

  Future<List<Lesson>?> getAllLessonsFromDb() async {
    lessons = await lessonUseCase.getAllLessons();
    return lessons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Lesson>?>(
          future: getAllLessonsFromDb(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListViewSeparated(
                  data: snapshot.data, buildListItem: _buildRow);
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createLesson(context);
        },
        tooltip: 'Créer une lesson',
        child: const Icon(Icons.add_task),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildRow(Lesson lesson) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(LessonView.tag, arguments: lesson);
      },
      title: Row(
        children: [Text(lesson.name)],
      ),
      subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lieu: ${lesson.ground}'),
            Text('Date: ${lesson.lessonDateTime}'),
            Text('Discipline: ${lesson.discipline}'),
            Text('Durée: ${lesson.duration} minutes'),
          ]),
    );
  }

  Future<void> _createLesson(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Créer une lesson'),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              hintText: "Nom de la lesson"),
                        ),
                        DropdownButton<String>(
                          value: groundValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              groundValue = newValue!;
                            });
                          },
                          items: Ground.values
                              .map<DropdownMenuItem<String>>((Ground value) {
                            return DropdownMenuItem<String>(
                              value: value.name,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                        TextField(
                          controller:
                              dateController, //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText:
                                  "Date de la lesson" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                        DropdownButton<int>(
                          value: durationValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              durationValue = newValue!;
                            });
                          },
                          items: <int>[30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                        DropdownButton<String>(
                          value: disciplineValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              disciplineValue = newValue!;
                            });
                          },
                          items: Discipline.values
                              .map<DropdownMenuItem<String>>(
                                  (Discipline value) {
                            return DropdownMenuItem<String>(
                              value: value.name,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: const Text('Ajouter'),
                onPressed: () {
                  createLesson();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  createLesson() {
    Lesson newLessonObject = Lesson(
        attendees: [],
        user: user.id!,
        ground: groundValue,
        name: nameController.value.text,
        discipline: disciplineValue,
        duration: durationValue,
        lessonDateTime: DateTime.parse(dateController.text));

    Future<Lesson?> createdLesson = lessonUseCase.createLesson(newLessonObject);

    setState(() {
      lessons?.add(newLessonObject);
      newLesson = newLessonObject;
    });
  }
}
