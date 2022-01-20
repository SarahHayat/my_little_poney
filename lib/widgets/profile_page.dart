import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_little_poney/mock/mock.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/widgets/horses_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilePage> {
  User user = User(
    "id",
    "profilePicture",
    24,
    "https://ffelink.com",
    "07 70 13 99 65",
    UserRole.rider,
    [],
    DateTime.now(),
    Type.dp,
    userName: "Amandine",
    password: "password",
    email: "amandine@gmail.com",
  );

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ffeProfileController = TextEditingController();

  late String dropdownValueRole;
  late String dropdownValueType;

  bool inEditForm = false;

  @override
  void initState() {
    super.initState();
    dropdownValueRole = user.role.name;
    dropdownValueType = user.type.name;
    emailController.text = user.email;
    usernameController.text = user.userName;
    phoneNumberController.text = user.phoneNumber;
    ffeProfileController.text = user.FFELink;
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
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(HorsesPage.routeName);
          },
          child: Icon(Icons.bedroom_baby ),
        ),
      ),
      body: Column(
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
      ),
      floatingActionButton: FloatingActionButton(
        child: (inEditForm) ? const Icon(Icons.close) : const Icon(Icons.edit),
        onPressed: () {
          displayEditform();
        },
      ),
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
                  Text("Profil FFE : ${user.FFELink}"),
                ],
              ),
              Row(
                children: [
                  Text("Rôle : ${user.role.name}"),
                ],
              ),
              Row(
                children: [
                  Text("Type : ${user.type.name}"),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                controller: emailController,
              ),
              TextFormField(
                controller: usernameController,
              ),
              TextFormField(
                controller: phoneNumberController,
              ),
              TextFormField(
                controller: ffeProfileController,
              ),
              buildDropdownRole(),
              buildDropdownType(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    inEditForm = false;
                    saveProfile();
                  });
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
          icon: const Icon(Icons.arrow_downward, size: 17,),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Type : '),
        DropdownButton(
          value: dropdownValueType,
          icon: const Icon(Icons.arrow_downward, size: 17,),
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
          Type.values.map<DropdownMenuItem<String>>((Type value) {
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
    user.FFELink = ffeProfileController.value.text;
    user.role = UserRole.values.firstWhere((el) => el.name == dropdownValueRole);
    user.type = Type.values.firstWhere((el) => el.name == dropdownValueType);
  }
}
