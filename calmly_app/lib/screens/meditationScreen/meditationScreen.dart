import 'package:calmly_app/components.dart/navBar.dart';
import 'package:calmly_app/components.dart/searchBar.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/meditationScreen/components/meditationSession.dart';
import 'package:flutter/material.dart';

class meditationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "meditation",
                      style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "take a moment to breathe",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Text(
                        "live happier and healthier by learning the fundamentals of meditation and mindfulness through practice.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF696969),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Text(
                        "take a deep breath, god knows you need it.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF696969),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: searchBar(),
                    ),
                    Wrap(
                      runSpacing: 15,
                      children: <Widget>[
                        meditationSession(
                          sessionNum: 0,
                          sessionTitle: "introduction",
                          isCompleted: true,
                          press: (){},
                        ),
                        meditationSession(
                          sessionNum: 1,
                          sessionTitle: "mindfulness",
                          isCompleted: true,
                          press: (){},
                        ),
                        meditationSession(
                          sessionNum: 2,
                          sessionTitle: "stress",
                          press: (){},
                        ),
                        meditationSession(
                          sessionNum: 3,
                          sessionTitle: "anxiety",
                          press: (){},
                        ),
                        meditationSession(
                          sessionNum: 4,
                          sessionTitle: "rejection",
                          press: (){},
                        ),
                        meditationSession(
                          sessionNum: 5,
                          sessionTitle: "heartbreak",
                          press: (){},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ), 
          ),
        ],
      ),
    );
  }
}

