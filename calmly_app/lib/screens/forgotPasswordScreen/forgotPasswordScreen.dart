import 'package:calmly_app/screens/forgotPasswordScreen/components/forgotPasswordBody.dart';
import 'package:calmly_app/screens/signupScreen/components/signupBackground.dart';
import 'package:calmly_app/screens/signupScreen/components/signupBody.dart';
import 'package:flutter/material.dart';

class forgotPasswordScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: forgotPasswordBody(),
    );
  }
}