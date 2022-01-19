import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/helper/temporaryContest.dart';
import 'contest_view.dart';

class ContestListView extends StatefulWidget {
  const ContestListView({Key? key, required this.title}) : super(key: key);
  static const tag = "contest_view_list";

  final String title;

  @override
  State<ContestListView> createState() => _ContestListState();
}

class _ContestListState extends State<ContestListView> {
  late List<Contest> contests = [contest, contest];
  late Contest newContest;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController pictureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildListView(contests, _buildRow),
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
            Text('Par : ${contest.user.userName}'),
          ]),
    );
  }

  Future<void> _createContest(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bière'),
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
                    TextFormField(
                      controller: dateController,
                      decoration:
                          const InputDecoration(hintText: "Date du concours"),
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
                  Navigator.of(context)
                      .pushNamed(ContestView.tag, arguments: newContest.id);
                },
              ),
            ],
          );
        });
  }

  createContest() {}
}
