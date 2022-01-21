import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_little_poney/helper/listview.dart';
import 'package:my_little_poney/models/Party.dart';
import 'package:my_little_poney/models/User.dart';
import 'party_view.dart';
import 'package:intl/intl.dart';
import 'package:my_little_poney/usecase/party_usecase.dart';

class PartyListView extends StatefulWidget {
  const PartyListView({Key? key, required this.title}) : super(key: key);
  static const tag = "party_view_list";

  final String title;

  @override
  State<PartyListView> createState() => _PartyListState();
}

class _PartyListState extends State<PartyListView> {
  PartyUseCase partyUseCase = PartyUseCase();
  final LocalStorage storage = LocalStorage('poney_app');
  late User user;

  late List<Party>? parties;

  late Party newParty;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String themeValue = ThemeParty.dinner.name;

  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    getAllPartiesFromDb();
    super.initState();
  }

  Future<List<Party>?> getAllPartiesFromDb() async {
    parties = await partyUseCase.getAllParties();
    return parties;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Party>?>(
          future: getAllPartiesFromDb(),
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
          _createParty(context);
        },
        tooltip: 'Créer une soirée',
        child: const Icon(Icons.add_task),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildRow(Party party) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(PartyView.tag, arguments: party);
      },
      title: Row(
        children: [Text(party.name)],
      ),
      subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Thème: ${party.theme}'),
            Text('Date: ${party.partyDateTime}'),
          ]),
    );
  }

  Future<void> _createParty(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Créer une soirée'),
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
                              hintText: "Nom de la soirée"),
                        ),
                        DropdownButton<String>(
                          value: themeValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              themeValue = newValue!;
                            });
                          },
                          items: ThemeParty.values
                              .map<DropdownMenuItem<String>>(
                                  (ThemeParty value) {
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
                                  "Date de la soirée" //label text of field
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
                  createParty();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  createParty() {
    Party newPartyObject = Party(
        attendeesParty: [],
        user: user.id!,
        theme: themeValue,
        name: nameController.value.text,
        partyDateTime: DateTime.parse(dateController.text));

    Future<Party?> createdParty = partyUseCase.createParty(newPartyObject);

    setState(() {
      parties?.add(newPartyObject);
      newParty = newPartyObject;
    });
  }
}
