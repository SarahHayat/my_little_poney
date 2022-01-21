import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:localstorage/localstorage.dart';

import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/horse_usecase.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';

import 'horse_dialog.dart';

class HorsesPage extends StatefulWidget {
  static const routeName = 'horsesPage';

  @override
  State<StatefulWidget> createState() => HorsesPageState();
}

class HorsesPageState extends State<HorsesPage> {
  final LocalStorage storage = LocalStorage('poney_app');
  HorseUseCase horseUseCase = HorseUseCase();
  UserUseCase userUseCase = UserUseCase();

  late List<Horse> horsesList;
  late User user;

  bool horseLinkToUser = false;
  bool isMyHorse = false;

  @override
  void initState() {
    user = User.fromJson(storage.getItem("user"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chevaux"),
      ),
      body: FutureBuilder<List<Horse>?>(
        future: getAllHorses(),
        builder: (BuildContext context, AsyncSnapshot<List<Horse>?> snapshot) {
          if (snapshot.hasData) {
            horsesList = snapshot.data!;
            return getBody();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        Center(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: horsesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  key: Key(horsesList[index].id!),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      (user.type == UserType.dp.name)
                          ? getSlidableActionForDpUser(
                              context, horsesList[index])
                          : getSlidableActionForOwnerUser(horsesList[index]),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      buildDialogDetail(horsesList[index]);
                    },
                    child: Card(
                      elevation: 5.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            horsesList[index].picturePath,
                            width: 150,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${horsesList[index].name}'),
                                  (horsesList[index].gender == Gender.male.name)
                                      ? const Icon(Icons.male)
                                      : const Icon(Icons.female)
                                ],
                              ),
                            ],
                          ),
                          (user.type == UserType.dp.name)
                              ? isUserIsAssociateToHorse(horsesList[index])
                              : isUserIsOwnerOfHorse(horsesList[index]),
                        ],
                      ),
                      // ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  isUserIsAssociateToHorse(Horse horse) {
    // the dp user has already one horse or the horse has already an owner
    if (user.horses!.contains(horse.id)) {
      return const Icon(Icons.link);
    } else {
      return const Icon(Icons.link_off);
    }
  }

  isUserIsOwnerOfHorse(Horse horse) {
    if (horse.owner == "" || horse.owner! != user.id) {
      return Container();
    } else if (horse.owner! == user.id) {
      return const Icon(Icons.attribution);
    }
  }

  getSlidableActionForDpUser(BuildContext context, Horse horse) {
    if (user.horses!.contains(horse.id)) {
      return SlidableAction(
        onPressed: (BuildContext) {
          setState(() {
            user.horses!.remove(horse.id);
          });
          updateUser();
        },
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.link_off,
        label: 'Se déassocier',
      );
    }
    return Container();
  }

  getSlidableActionForOwnerUser(Horse horse) {
    if (horse.owner != "" && horse.owner! == user.id) {
      return SlidableAction(
        onPressed: (BuildContext) {
          setState(() {
            horse.owner = "";
          });
          updateHorse(horse);
        },
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.close,
        label: 'ne plus être proprio',
      );
    }
    return Container();
  }

  Future buildDialogDetail(Horse horse) {
    final dial = showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return SimpleDialog(
          elevation: 8.0,
          contentPadding: EdgeInsets.all(15),
          children: [HorseDialog(horse)],
        );
      },
    );
    return dial.then((_) => setState(() {}));
  }

  Future<List<Horse>?> getAllHorses() async {
    return await horseUseCase.getAllHorses();
  }

  Future<Horse?> updateHorse(Horse horse) async {
    final result = await horseUseCase.updateHorseById(horse);
    return result;
  }

  Future<User> updateUser() async {
    final result = await userUseCase.updateUserById(user);
    storage.setItem("user", user.toJson());
    return result;
  }
}
