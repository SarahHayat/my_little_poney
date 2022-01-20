import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// import 'package:my_little_poney/mock/mock.dart';
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
  HorseUseCase horseUseCase = HorseUseCase();
  UserUseCase userUseCase = UserUseCase();

  late List<Horse> horsesList;
  late User user;
  String userId = "61e88761ffa82f1606d47565";

  bool horseLinkToUser = false;
  bool isMyHorse = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Chevaux"),
        ),
        body: FutureBuilder<List<Horse>?>(
          future: getAllHorses(),
          builder: (BuildContext context, AsyncSnapshot<List<Horse>?> snapshot) {
            print('snapchot before =${snapshot.data}');
            if (snapshot.hasData) {
              print('snapchot = $snapshot');
              horsesList = snapshot.data!;
              // user = snapshot.data['user'];
              return getBody();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),);
  }

  Widget getBody(){
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
                      (user.type == UserType.dp)
                          ? getSlidableActionForDpUser(
                          context, horsesList[index])
                          : getSlidableActionForOwnerUser(
                          horsesList[index]),
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
                            "https://cdn.radiofrance.fr/s3/cruiser-production/2021/03/e51f683c-1f29-4136-8e62-31baa8fbf95a/1280x680_origines-equides-cheval.jpg",
                            width: 150,
                          ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${horsesList[index].name}'),
                                  (horsesList[index].gender == Gender.male)
                                      ? const Icon(Icons.male)
                                      : const Icon(Icons.female)
                                ],
                              ),
                            ],
                          ),
                          (user.type == UserType.dp)
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
    if (user.horses!.contains(horse)) {
      return Icon(Icons.link);
    } else {
      return Icon(Icons.link_off);
    }
  }

  isUserIsOwnerOfHorse(Horse horse) {
    if (horse.owner == null || horse.owner!.id != user.id) {
      return Container();
    } else if (horse.owner!.id == user.id) {
      return const Icon(Icons.attribution);
    }
  }

  getSlidableActionForDpUser(BuildContext context, Horse horse) {
    if (user.horses!.contains(horse.id)) {
      return SlidableAction(
        onPressed: (BuildContext) => setState(() {
          user.horses!.remove(horse.id);
        }),
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.link_off,
        label: 'Se déassocier',
      );
    }
    return Container();
  }

  getSlidableActionForOwnerUser(Horse horse) {
    if (horse.owner != null && horse.owner!.id == user.id) {
      return SlidableAction(
        onPressed: (BuildContext) => setState(() {
          horse.owner = null;
        }),
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'stop proprio',
      );
    }
    return Container();
  }

  Future<Null> buildDialogDetail(Horse horse) {
    return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return SimpleDialog(
          elevation: 8.0,
          contentPadding: EdgeInsets.all(15),
          children: [HorseDialog(horse)],
        );
      },
    );
  }

  Future<List<Horse>?> getAllHorses() async {
    return await horseUseCase.getAllHorses();
  }

  Future<List<Horse>?> getAllData()async {
    // print('here');
    // final resUser = await userUseCase.fetchUserById(userId);
    // print('res user =$resUser');
    final resHorse = await horseUseCase.getAllHorses();
    // print('res horse =$resUser');
    // final data ={
    //   "user": resUser,
    //   "horsesList": resHorse,
    // };
    // print(data);
    print("res $resHorse");
    return resHorse;
  }
}
