import 'package:flutter/material.dart';

class articleScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget> [
                Container(
                  width: double.infinity,
                  height: size.height * 0.7,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/welcome.png"),
                      fit: BoxFit.fitWidth
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}