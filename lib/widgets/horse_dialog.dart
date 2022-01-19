import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/User.dart';

class HorseDialog extends StatefulWidget {
  static const routeName = 'horseDialog';
  Horse horse;

  HorseDialog(this.horse, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HorseDialogState();
}

class HorseDialogState extends State<HorseDialog> {
  static User user = User(
    "id",
    "profilePicture",
    24,
    "https://ffelink.com",
    "07 70 13 99 65",
    UserRole.rider,
    [],
    DateTime.now(),
    Type.owner,
    userName: "Amandine",
    password: "password",
    email: "amandine@gmail.com",
  );
  TextEditingController horseNameController = TextEditingController();
  TextEditingController horseAgeController = TextEditingController();
  TextEditingController horseDressController = TextEditingController();

  bool inEditForm = false;
  bool canEditHorse = false;

  late String dropdownValueRace;
  late String dropdownValueSpeciality;
  late Gender radioValueGender;

  @override
  void initState() {
    super.initState();
    checkIfUserCanEditHorse();
    dropdownValueRace = widget.horse.race.name;
    dropdownValueSpeciality = widget.horse.speciality.name;
    radioValueGender = widget.horse.gender;

    horseNameController.text = widget.horse.name;
    horseAgeController.text = widget.horse.age.toString();
    horseDressController.text = widget.horse.dress;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: (inEditForm) ? buildHorseForm() : buildHorseInfo(),
    );
  }

  List<Widget> buildHorseInfo() {
    List<Widget> list = [
      Image.network(
        "https://cdn.radiofrance.fr/s3/cruiser-production/2021/03/e51f683c-1f29-4136-8e62-31baa8fbf95a/1280x680_origines-equides-cheval.jpg",
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.horse.name),
          (widget.horse.gender == Gender.male)
              ? const Icon(Icons.male)
              : const Icon(Icons.female)
        ],
      ),
      Text('Robe : ${widget.horse.dress} '),
      Text('Specialité : ${widget.horse.speciality.name}'),
      Text('Age : ${widget.horse.age} ans'),
      Text('Race : ${widget.horse.race.name} '),
      (user.type == Type.dp) ? buildDpButton() : buildOwnerButton(),
      (canEditHorse)
          ? ElevatedButton(
              onPressed: () {
                setState(() {
                  inEditForm = (inEditForm) ? false : true;
                });
              },
              child: (inEditForm) ? const Icon(Icons.close) : const Icon(Icons.edit),
            )
          : Container()
    ];
    return list;
  }

  List<Widget> buildHorseForm() {
    List<Widget> list = [
      Image.network(
        "https://cdn.radiofrance.fr/s3/cruiser-production/2021/03/e51f683c-1f29-4136-8e62-31baa8fbf95a/1280x680_origines-equides-cheval.jpg",
        // height: 100,
        width: 200,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Nom', labelStyle: TextStyle(color: Colors.black)),
        controller: horseNameController,
      ),
      const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Genre ',
            style: TextStyle(fontSize: 13),
          ),
        ),
      ),
      buildRadioButtonGender(),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Robe', labelStyle: TextStyle(color: Colors.black)),
        controller: horseDressController,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Age', labelStyle: TextStyle(color: Colors.black)),
        controller: horseAgeController,
      ),
      buildDropdown(dropdownValue: dropdownValueRace, horseRace: true ,speciality: null),
      buildDropdown(dropdownValue: dropdownValueSpeciality, speciality: true, horseRace: null),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          (canEditHorse)
              ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      inEditForm = (inEditForm) ? false : true;
                    });
                  },
                  child: (inEditForm) ? const Icon(Icons.close) : const Icon(Icons.edit),
                )
              : Container(),
          ElevatedButton(
            onPressed: () {
              setState(() {
                inEditForm = false;
                submitHorseForm();
              });
            },
            child: Text('Enregistrer'),
          ),
        ],
      )
    ];
    return list;
  }

  buildDpButton() {
    // the dp user has already one horse or the horse has already an owner
    if (user.horses.length == 1 || widget.horse.owner != null) {
      return Container();
    }
    return ElevatedButton(
      onPressed: () {
        setState(() {
          user.horses.add(widget.horse);
        });
      },
      child: Text("S'associer' à ${widget.horse.name}"),
    );
  }

  buildOwnerButton() {
    // the horse has already an owner
    if (widget.horse.owner != null) {
      return Container();
    }
    return ElevatedButton(
      onPressed: () {
        setState(() {
          user.horses.add(widget.horse);
          widget.horse.owner = user;
          canEditHorse = true;
        });
      },
      child: Text("devenir propriétaire de ${widget.horse.name}"),
    );
  }

  buildDropdown(
      {required String dropdownValue, required bool? horseRace, required bool? speciality}) {
    List<DropdownMenuItem<String>> list;
    if(horseRace != null){
      list  = HorseRace.values.map<DropdownMenuItem<String>>((HorseRace value) {
        return DropdownMenuItem<String>(
          value: value.name,
          child: Text(value.name),
        );
      }).toList();
    }else{
      list = Speciality.values.map<DropdownMenuItem<String>>((Speciality value) {
        return DropdownMenuItem<String>(
          value: value.name,
          child: Text(value.name),
        );
      }).toList();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        (horseRace != null)? Text("Race: "):Text('Spécialité: '),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_downward,
            size: 17,
          ),
          elevation: 16,
          underline: Container(
            height: 2,
          ),
          onChanged: (String? newValue) {
            setState(() {
              if( dropdownValue == dropdownValueRace){
                dropdownValueRace = newValue!;
              }
              else{
                dropdownValueSpeciality = newValue!;
              }
            });
          },
          items:
          list,
        ),
      ],
    );
  }

  buildRadioButtonGender() {
    List<Widget> genderRadio = [];
    for (Gender gender in Gender.values) {
      Widget r = Radio(
        visualDensity: VisualDensity.compact,
        value: gender,
        groupValue: radioValueGender,
        onChanged: (Gender? value) {
          setState(() {
            radioValueGender = value!;
          });
        },
      );
      Widget t = Text(gender.name);
      genderRadio.add(r);
      genderRadio.add(t);
    }
    return Column(
      children: [
        Row(
          children: genderRadio,
        ),
      ],
    );
  }

  submitHorseForm() {
    widget.horse.name = horseNameController.value.text;
    widget.horse.dress = horseDressController.value.text;
    widget.horse.age = int.parse(horseAgeController.value.text);
    widget.horse.race =
        HorseRace.values.firstWhere((el) => el.name == dropdownValueRace);
    widget.horse.speciality = Speciality.values
        .firstWhere((el) => el.name == dropdownValueSpeciality);
    widget.horse.gender = radioValueGender;
  }

  checkIfUserCanEditHorse() {
    if (user.type == Type.owner && widget.horse.owner != null) {
      if (widget.horse.owner!.id == user.id) {
        setState(() {
          canEditHorse = true;
        });
      }
    } else {
      setState(() {
        canEditHorse = false;
      });
    }
  }
}
