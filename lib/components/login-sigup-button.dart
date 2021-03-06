import 'package:flutter/material.dart';

class LoginSignupButton extends StatelessWidget {
  final String title;
  final dynamic  ontapp;
  final width;

  const LoginSignupButton({Key? key, required this.title, required this.ontapp, this.width = double.infinity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed:
          ontapp,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black45),
          ),
        ),
      ),
    );
  }
}