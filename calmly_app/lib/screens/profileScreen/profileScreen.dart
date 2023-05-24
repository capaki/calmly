import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/screens/profileScreen/profileBody.dart';

class profileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: profileBody(),
    );
  }
}
