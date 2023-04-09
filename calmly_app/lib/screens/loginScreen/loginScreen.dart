import 'package:calmly_app/screens/loginScreen/components/loginBody.dart';
import 'package:calmly_app/screens/loginScreen/components/loginBody.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: loginBody(),
    );
  }
}

