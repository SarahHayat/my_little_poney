import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/horse_usecase.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';
import 'package:my_little_poney/widgets/navigation.dart';

class HorseDialog extends StatefulWidget {
  static const routeName = 'horseDialog';
  Horse horse;

  HorseDialog(this.horse, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HorseDialogState();
}

class HorseDialogState extends State<HorseDialog> {
  final LocalStorage storage = LocalStorage('poney_app');
  HorseUseCase horseUseCase = HorseUseCase();
  UserUseCase userUseCase = UserUseCase();
  late User user;

  TextEditingController horseNameController = TextEditingController();
  TextEditingController horseAgeController = TextEditingController();
  TextEditingController horseDressController = TextEditingController();
  TextEditingController horsePhotoController = TextEditingController();

  bool inEditForm = false;
  bool canEditHorse = false;

  late String dropdownValueRace;
  late String dropdownValueSpeciality;
  late String radioValueGender;

  @override
  void initState() {
    super.initState();
    user = User.fromJson(storage.getItem('user'));
    checkIfUserCanEditHorse();
    dropdownValueRace = widget.horse.race;
    dropdownValueSpeciality = widget.horse.speciality;
    radioValueGender = widget.horse.gender;

    horseNameController.text = widget.horse.name;
    horseAgeController.text = widget.horse.age.toString();
    horseDressController.text = widget.horse.dress;
    horsePhotoController.text = (widget.horse.picturePath != "") ? widget.horse.picturePath : "https://cdn.pixabay.com/photo/2013/10/17/20/59/horse-197199__340.jpg" ;
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
      Image.network(widget.horse.picturePath),
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
      Text('Specialité : ${widget.horse.speciality}'),
      Text('Age : ${widget.horse.age} ans'),
      Text('Race : ${widget.horse.race} '),
      (user.type == UserType.dp.name) ? buildDpButton() : buildOwnerButton(),
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
        widget.horse.picturePath,
        // height: 100,
        width: 200,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Photo url', labelStyle: TextStyle(color: Colors.black)),
        controller: horsePhotoController,
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
              updateHorse();
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
    print('user.horses!.length = ${user.horses!.length}');
    print('widget.horse.owner = ${widget.horse.owner}');
    if (user.horses!.length == 1) {
      return Container();
    }
    return ElevatedButton(
      onPressed: () {
        setState(() {
          user.horses!.add(widget.horse.id);
        });
        updateUser();
        Navigator.of(context).pop();
      },
      child: Text("S'associer' à ${widget.horse.name}"),
    );
  }

  buildOwnerButton() {
    print('widget.horse.owner = ${widget.horse.owner}');
    // the horse has already an owner
    if (widget.horse.owner != "") {
      return Container();
    }
    return ElevatedButton(
      onPressed: () {
        setState(() {
          user.horses!.add(widget.horse.id);
          widget.horse.owner = user.id;
          canEditHorse = true;
        });
        updateHorse();
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
        value: gender.name,
        groupValue: radioValueGender,
        onChanged: (value) {
          setState(() {
            print('value radio button in set state = $value');
            radioValueGender = value as String;
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
    widget.horse.race = dropdownValueRace;
    widget.horse.speciality = dropdownValueSpeciality;
    widget.horse.gender = radioValueGender;
    widget.horse.picturePath = horsePhotoController.value.text;
  }

  Future<Horse?> updateHorse()async {
    final result = await horseUseCase.updateHorseById(widget.horse);
    return result;
  }

  Future<User> updateUser() async {
    final result = await userUseCase.updateUserById(user);
    storage.setItem("user", user.toJson());
    return result;
  }

  checkIfUserCanEditHorse() {
    if (user.type == UserType.owner.name && widget.horse.owner != "") {
      if (widget.horse.owner! == user.id) {
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
