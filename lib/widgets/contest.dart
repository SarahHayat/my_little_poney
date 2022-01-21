import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/helper/temporaryContest.dart';
import 'package:my_little_poney/models/User.dart';
import 'contest_view.dart';
import 'package:intl/intl.dart';
import 'package:my_little_poney/usecase/contest_usecase.dart';

class ContestListView extends StatefulWidget {
  const ContestListView({Key? key, required this.title}) : super(key: key);
  static const tag = "contest_view_list";

  final String title;

  @override
  State<ContestListView> createState() => _ContestListState();
}

class _ContestListState extends State<ContestListView> {
  ContestUseCase contestUseCase = ContestUseCase();

  late List<Contest>? contests;
  final LocalStorage storage = LocalStorage('poney_app');
  late User user;
  late Contest newContest;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController pictureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = ""; //set the initial value of text field
    getAllContestsFromDb();
    user = User.fromJson(storage.getItem('user'));
  }

  Future<List<Contest>?> getAllContestsFromDb() async {
    contests = await contestUseCase.getAllContests();
    return contests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Contest>?>(
          future: getAllContestsFromDb(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListViewSeparated(data: snapshot.data,buildListItem: _buildRow);
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createContest(context);
        },
        tooltip: 'Créer un concours',
        child: const Icon(Icons.add_task),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildRow(Contest contest) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(ContestView.tag, arguments: contest);
      },
      title: Row(
        children: [Text(contest.name)],
      ),
      subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adresse: ${contest.address}'),
            Text('Date: ${contest.contestDateTime}'),
            Text('Créée le : ${contest.createdAt}'),
          ]),
    );
  }

  Future<void> _createContest(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ajouter un concours'),
            content: Card(
              elevation: 5,
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(hintText: "Nom du concours"),
                    ),
                    TextFormField(
                      controller: adressController,
                      decoration: const InputDecoration(
                          hintText: "Adresse du concours"),
                    ),
                    TextField(
                      controller:
                          dateController, //editing controller of this TextField
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Date" //label text of field
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
                    TextFormField(
                      controller: pictureController,
                      decoration:
                          const InputDecoration(hintText: "Photo du concours"),
                    ),
                  ],
                ),
              ),
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
                  createContest();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }).then((_) => setState(() {}));
  }

  createContest() {
    Contest newContestObject = Contest(
      user: user.id!,
      attendeesContest: [],
      name: nameController.value.text,
      address: adressController.value.text,
      picturePath: pictureController.value.text,
      contestDateTime: DateTime.parse(dateController.text)
    );

    Future<Contest?> createdContest =
        contestUseCase.createContest(newContestObject);

    setState(() {
      contests?.add(newContestObject);
      newContest = newContestObject;
    });
  }
}
