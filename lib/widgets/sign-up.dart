import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_little_poney/components/login-sigup-button.dart';
import 'package:my_little_poney/components/message-dialog.dart';
import 'package:my_little_poney/constants/constants.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';

import 'login.dart';
import 'navigation.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  final LocalStorage storage = LocalStorage('poney_app');
  UserUseCase userUseCase = UserUseCase();

  String email = '';
  String userName = '';
  String password = '';
  String urlPhoto = '';
  String profilePicture =
      "https://cdn.pixabay.com/photo/2016/03/23/04/01/woman-1274056_1280.jpg";
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Inscription réussi, veuillez vous connecter !'),
      action: SnackBarAction(
        label: 'Connexion',
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen()));
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => const LoginScreen())),
        ),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formkey,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Hero(
                              tag: '1',
                              child: Text(
                                "Inscription",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Column(children: [
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          NetworkImage(profilePicture),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              LoginSignupButton(
                                  title: 'Uploader photo',
                                  width: 200.0,
                                  ontapp: () {
                                    dialogueSignUp();
                                  }),
                            ]),
                            const SizedBox(height: 30),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                email = value.toString().trim();
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: "Entrez votre email",
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                userName = value.toString().trim();
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Entrez votre prénom',
                                prefixIcon: const Icon(
                                  Icons.account_circle,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              obscureText: true,
                              onChanged: (value) {
                                password = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Entrez votre mot de passe',
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  )),
                            ),
                            const SizedBox(height: 80),
                            LoginSignupButton(
                                title: 'Enregistrer',
                                ontapp: () async {
                                  setState(() {
                                    isloading = true;
                                  });
                                  userUseCase
                                      .createUser(User(
                                          email: email,
                                          password: password,
                                          userName: userName,
                                          profilePicture: profilePicture))
                                      .then((user) {
                                    setState(() {
                                      isloading = false;
                                    });
                                    storage.setItem('user', user.toJson());
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }).catchError((onError) {
                                    setState(() {
                                      isloading = false;
                                    });
                                    dialogue('Erreur création de compte');
                                  });
                                }),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<Null> dialogueSignUp() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Url'),
            contentPadding: const EdgeInsets.all(20.0),
            children: [
              Container(
                height: 25.0,
              ),
              TextField(
                onChanged: (value) {
                  urlPhoto = value;
                },
              ),
              Container(
                height: 25.0,
              ),
              LoginSignupButton(
                  title: 'Envoyer',
                  width: 100.0,
                  ontapp: () {
                    setState(() {
                      profilePicture = urlPhoto;
                    });
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  Future<void> dialogue(String message) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(title: message);
        });
  }
}
