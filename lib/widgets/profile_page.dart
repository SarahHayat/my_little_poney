import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localstorage/localstorage.dart';

// import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';
import 'package:my_little_poney/widgets/horses_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilePage> {

  final LocalStorage storage = LocalStorage('poney_app');
  UserUseCase userUseCase = UserUseCase();

  late User user;
  String userId = "61e88761ffa82f1606d47565";

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ffeProfileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  late String dropdownValueRole;
  late String dropdownValueType;

  bool inEditForm = false;

  @override
  void initState() {
    user = User.fromJson(storage.getItem("user"));

    emailController.text = user.email;
    usernameController.text = user.userName;
    phoneNumberController.text = (user.phoneNumber != "") ? user.phoneNumber! : "";
    ffeProfileController.text = (user.ffeLink != "") ? user.ffeLink!:  "";
    ageController.text = (user.age != 0) ? user.age.toString() : "";
    photoController.text = (user.profilePicture != "") ? user.profilePicture! : "https://cdn.pixabay.com/photo/2020/10/29/03/22/dog-5695088__340.png";
    dropdownValueRole = (user.role != "") ? user.role!:  UserRole.values.first.name;
    dropdownValueType = (user.type != "") ? user.type!:  UserType.values.first.name;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    ffeProfileController.dispose();
    ageController.dispose();
    photoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(HorsesPage.routeName);
          },
          child: const Icon(Icons.bedroom_baby),
        ),
      ),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        child: (inEditForm) ? const Icon(Icons.close) : const Icon(Icons.edit),
        onPressed: () {
          displayEditform();
        },
      ),
    );
  }

  Widget buildBody() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(user.profilePicture!),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            )
          ],
        ),
        (inEditForm) ? buildFormCard(size) : buildInfoColumn(size),
      ],
    );
  }

  displayEditform() {
    setState(() {
      inEditForm = (inEditForm) ? false : true;
    });
  }

  Widget buildInfoColumn(size) {
    return Expanded(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text("Email : ${user.email}"),
                ],
              ),
              Row(
                children: [
                  Text("Téléphone : ${user.phoneNumber}"),
                ],
              ),
              Row(
                children: [
                  Text("Age : ${user.age}"),
                ],
              ),
              Row(
                children: [
                  Text("Profil FFE : ${user.ffeLink!}"),
                ],
              ),
              Row(
                children: [
                  Text("Rôle : ${user.role}"),
                ],
              ),
              Row(
                children: [
                  Text("Type : ${user.type}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildFormCard(size) {
    return Expanded(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Photo url',
                    labelStyle: TextStyle(color: Colors.black)),
                controller: photoController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black)),
                controller: emailController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.black)),
                controller: usernameController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Téléphone',
                    labelStyle: TextStyle(color: Colors.black)),
                controller: phoneNumberController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(color: Colors.black)),
                controller: ageController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'FFE Profile',
                    labelStyle: TextStyle(color: Colors.black)),
                controller: ffeProfileController,
              ),
              buildDropdownRole(),
              buildDropdownType(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    inEditForm = false;
                  });
                  saveProfile();
                  updateUser();

                },
                child: const Text('Enregistrer'),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildDropdownRole() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Rôle : '),
        DropdownButton(
          value: dropdownValueRole,
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
              dropdownValueRole = newValue!;
            });
          },
          items:
              UserRole.values.map<DropdownMenuItem<String>>((UserRole value) {
            return DropdownMenuItem<String>(
              value: value.name,
              child: Text(value.name),
            );
          }).toList(),
        ),
      ],
    );
  }

  buildDropdownType() {
    // dropdownValueType =
    //     (user.type != "") ? user.type! : UserType.values.first.name;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Type : '),
        DropdownButton(
          value: dropdownValueType,
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
              dropdownValueType = newValue!;
            });
          },
          items:
              UserType.values.map<DropdownMenuItem<String>>((UserType value) {
            return DropdownMenuItem<String>(
              value: value.name,
              child: Text(value.name),
            );
          }).toList(),
        ),
      ],
    );
  }

  saveProfile() {
    user.email = emailController.value.text;
    user.userName = usernameController.value.text;
    user.phoneNumber = phoneNumberController.value.text;
    user.age = int.parse(ageController.value.text);
    user.profilePicture = photoController.value.text;
    user.ffeLink = ffeProfileController.value.text;
    user.role = dropdownValueRole;
    user.type = dropdownValueType;
  }

  Future<User> updateUser() async {
    final result = await userUseCase.updateUserById(user);
    storage.setItem("user", user.toJson());
    return result;
  }
}
