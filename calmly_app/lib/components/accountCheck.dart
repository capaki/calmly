// ignore_for_file: prefer_const_constructors

import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class accountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const accountCheck({
    super.key,
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "don't have an account yet? " : "already have an account? ",
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "SIGN UP" : "LOG IN",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
