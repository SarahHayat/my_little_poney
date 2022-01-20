import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_little_poney/components/login-sigup-button.dart';
import 'package:my_little_poney/constants/constants.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';
import 'package:my_little_poney/widets/navigation.dart';
import 'package:my_little_poney/widets/test.dart';
import 'package:my_little_poney/widgets/sign-up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final LocalStorage storage = LocalStorage('poney_app');
  String email = '';
  String password = '';
  bool isloading = false;
  UserUseCase userUseCase = UserUseCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Connexion",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Email";
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Password";
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(height: 80),
                      LoginSignupButton(
                        title: 'Login',
                        ontapp: () async {
                          userUseCase.api.loggin(email, password).then((user)
                          {
                            storage.setItem('user', user.toJson());
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Navigation()));
                          }).catchError((onError) {
                            const AlertDialog();
                          });

                        },
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignupScreen()));
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => SignupScreen(),
                          //   ),
                          // );
                        },
                        child: Row(
                          children: const [
                            Text(
                              "Créer un compte ?",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black87),
                            ),
                            SizedBox(width: 10),
                            Hero(
                              tag: '1',
                              child: Text(
                                'Inscription',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      )
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
}