import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';
import 'package:my_little_poney/widgets/horses_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilePage> {
  UserUseCase userUseCase = UserUseCase();

  late User user;
  String userId = "61e88761ffa82f1606d47565";

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ffeProfileController = TextEditingController();

  // late String dropdownValueRole;
  // late String dropdownValueType;
  String dropdownValueRole = UserRole.values.first.name;
  String dropdownValueType = UserType.values.first.name;

  bool inEditForm = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    ffeProfileController.dispose();
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
          child: Icon(Icons.bedroom_baby),
        ),
      ),
      body: FutureBuilder<User>(
        future: getUser(userId),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data!;
            emailController.text = user.email;
            usernameController.text = user.userName;
            phoneNumberController.text = user.phoneNumber ?? "";
            ffeProfileController.text = user.ffeLink ?? "";
            return buildBody();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
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
            Container(
              height: size.height * 0.13,
              width: size.width,
              color: Colors.blue,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://cdn.pixabay.com/photo/2016/03/23/04/01/woman-1274056_1280.jpg"),
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
    print('feee value  = ${ffeProfileController.value.text}');

    user.ffeLink = ffeProfileController.value.text;
    print('drop value role = $dropdownValueRole');
    user.role = dropdownValueRole;
    print('drop value type = $dropdownValueType');
    user.type = dropdownValueType;
  }

  Future<User> getUser(userId) async {
    return await userUseCase.fetchUserById(userId);
  }

  Future<User> updateUser() async {
    print('user role = ${user.role}');
    print('user type = ${user.type}');
    print('user ffe = ${user.ffeLink}');

    return await userUseCase.updateUserById(user);
  }
}
