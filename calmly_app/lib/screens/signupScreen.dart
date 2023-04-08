import 'package:calmly_app/components.dart/signupBackground.dart';
import 'package:calmly_app/components.dart/signupBody.dart';
import 'package:flutter/material.dart';

class signupScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: signupBody(),
    );
  }
}



