import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_little_poney/components/login-sigup-button.dart';
import 'package:my_little_poney/components/message-dialog.dart';
import 'package:my_little_poney/constants/constants.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';
import 'package:my_little_poney/widgets/login.dart';


class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);
  static const routeName = 'reset_screen';

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final formkey = GlobalKey<FormState>();

  String email = '';
  String userName = '';
  String password = '';
  bool isloading = false;
  bool isReset = false;
  UserUseCase userUseCase = UserUseCase();
  late User userReset;

  @override
  Widget build(BuildContext context) {
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
                              tag: '2',
                              child: Text(
                                "Réinitialiser mot de passe",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                email = value;
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
                              onChanged: (value) {
                                userName = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Prénom',
                                  prefixIcon: const Icon(
                                    Icons.account_circle,
                                    color: Colors.black,
                                  )),
                            ),
                            const SizedBox(height: 80),
                            LoginSignupButton(
                              title: 'Demande de réiniatilisation',
                              ontapp: () async {
                                isloading = true;
                                userUseCase
                                    .resetPassword(email, userName)
                                    .then((user) {
                                  setState(() {
                                    isloading = false;
                                    isReset = true;
                                    userReset = user;
                                  });
                                }).catchError((onError) {
                                  setState(() {
                                    isloading = false;
                                  });
                                  dialogue("Utilisateur introuvable");
                                });
                              },
                            ),
                            const SizedBox(height: 30),
                            isReset
                                ? Column(
                                    children: [
                                      const SizedBox(height: 50),
                                      TextFormField(
                                        obscureText: true,
                                        onChanged: (value) {
                                          password = value;
                                        },
                                        textAlign: TextAlign.center,
                                        decoration:
                                            kTextFieldDecoration.copyWith(
                                                hintText: 'Mot de passe',
                                                prefixIcon: const Icon(
                                                  Icons.lock,
                                                  color: Colors.black,
                                                )),
                                      ),
                                      const SizedBox(height: 80),
                                      LoginSignupButton(
                                        title: 'Réinitialiser',
                                        ontapp: () async {
                                          isloading = true;
                                          userReset.password = password;
                                          userUseCase
                                              .updateUserById(userReset)
                                              .then((user) {
                                            setState(() {
                                              isloading = false;
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext context) => const LoginScreen())
                                              );
                                            });
                                          }).catchError((onError) {
                                            setState(() {
                                              isloading = false;
                                            });
                                            dialogue('Erreur réinitialisation du mot de passe');
                                          });
                                        },
                                      )
                                    ],
                                  )
                                : const SizedBox(height: 30),
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

  Future<void> dialogue(String message) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return MessageDialog(
              title: message
          );
        }
    );
  }
}
