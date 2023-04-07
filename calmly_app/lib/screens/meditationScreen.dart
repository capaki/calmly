import 'package:calmly_app/components.dart/navBarWidget.dart';
import 'package:calmly_app/components.dart/searchBarWidget.dart';
import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class meditationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: navBarWidget(),
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
                        "live happier and healthier by learning the fundamentals of meditation and mindfulness through practice. take a deep breath, god knows you need it.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF696969),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: searchBarWidget(),
                    ),
                    Wrap(
                      runSpacing: 15,
                      children: <Widget>[
                        sessionWidget(
                          sessionNum: 0,
                          sessionTitle: "introduction",
                          isCompleted: true,
                          press: (){},
                        ),
                        sessionWidget(
                          sessionNum: 1,
                          sessionTitle: "stress",
                          isCompleted: true,
                          press: (){},
                        ),
                        sessionWidget(
                          sessionNum: 2,
                          sessionTitle: "anxiety",
                          press: (){},
                        ),
                        sessionWidget(
                          sessionNum: 3,
                          sessionTitle: "rejection",
                          press: (){},
                        ),
                        sessionWidget(
                          sessionNum: 4,
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

class sessionWidget extends StatelessWidget {
  final int sessionNum;
  final String sessionTitle;
  final isCompleted;
  final VoidCallback press;
  const sessionWidget({
    super.key, 
    required this.sessionNum, 
    required this.sessionTitle,
    this.isCompleted = false, 
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        //padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 23,
              spreadRadius: -20,
            )
          ]
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 42,
                    width: 43,
                    decoration: BoxDecoration(
                      color: isCompleted ? Colors.white : kBlueColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: kBlueColor),
                    ),
                    child: Icon(
                      Icons.play_arrow, 
                      color: isCompleted ? kBlueColor : Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "session  $sessionNum - $sessionTitle",
                    style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                    fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}