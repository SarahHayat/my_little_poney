import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_little_poney/components/login-sigup-button.dart';
import 'package:my_little_poney/constants/constants.dart';
import 'package:my_little_poney/models/Horse.dart';
import 'package:my_little_poney/models/User.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  // final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;

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
                        "Sign In",
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

                          CollectionReference horseRef = FirebaseFirestore.instance.collection('horses')
                              .withConverter<Horse>(
                                    fromFirestore: (snapshot, _) => Horse.fromJson(snapshot.data()!),
                                    toFirestore: (horse, _) => horse.toJson(),
                          );


                          CollectionReference userRef = FirebaseFirestore.instance.collection('users')
                              .withConverter<User>(
                            fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
                            toFirestore: (user, _) => user.toJson(),
                          );

                          horseRef.add(
                            Horse(
                                name: "étole d'argent",
                                owner: userRef.doc('SbeW3uQKszmHEGy1p3oL'),
                                age: 2,
                                picturePath: "picturePath",
                                dress: "dress",
                                race: HorseRace.mustang,
                                gender: Gender.other,
                                speciality: Speciality.endurance,
                                createdAt: DateTime.now()
                            )
                          );


                          // await usersRef.add(User(
                          //     "1",
                          //     "profilePicture",
                          //     20,
                          //     "FFELink",
                          //     "phoneNumber",
                          //     UserRole.rider,
                          //     [],
                          //     DateTime.now(),
                          //     Type.dp,
                          //     userName: "toto",
                          //     password: "123",
                          //     email: "toto@gmail.com"
                          // ));

                          // print('helli');
                          // HorseQuerySnapshot userQuery = await horsesRef.get();
                          // print('hello');
                          // for (HorseQueryDocumentSnapshot doc in userQuery.docs ) {
                          //   print('hallo');
                          //   print(doc.data.owner);
                          // }

                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            // try {
                            //   // await _auth.signInWithEmailAndPassword(
                            //   //     email: email, password: password);
                            //
                            //   // print(_auth.currentUser);
                            //
                            //   setState(() {
                            //     isloading = false;
                            //   });
                            // } on FirebaseAuthException catch (e) {
                            //   showDialog(
                            //     context: context,
                            //     builder: (ctx) => AlertDialog(
                            //       title: const Text("Ops! Login Failed"),
                            //       content: Text('${e.message}'),
                            //       actions: [
                            //         TextButton(
                            //           onPressed: () {
                            //             Navigator.of(ctx).pop();
                            //           },
                            //           child: const Text('Okay'),
                            //         )
                            //       ],
                            //     ),
                            //   );
                            //   print(e);
                            // }
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => SignupScreen(),
                          //   ),
                          // );
                        },
                        child: Row(
                          children: const [
                            Text(
                              "Don't have an Account ?",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black87),
                            ),
                            SizedBox(width: 10),
                            Hero(
                              tag: '1',
                              child: Text(
                                'Sign up',
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