import 'package:calmly_app/components.dart/navBar.dart';
import 'package:calmly_app/components.dart/searchBar.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/infoScreen/components/infoArticle.dart';
import 'package:flutter/material.dart';

class infoScreen extends StatelessWidget{
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
              color: kInfoColor,
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
                      "get informed",
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
                      "get to know your mind better",
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
                          color: Color(0xFF8F8F8F),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Text(
                        "take a deep breath, god knows you need it.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8F8F8F),
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
                        infoArticle(
                          articleTitle: "introduction",
                          articleDetail: "a brief introduction into the complex parts of the human brain. learn how your brain functions under various emotions such as stress, anxity, happiness etc",
                          isCompleted: true,
                          press: (){},
                        ),
                        infoArticle(
                          articleTitle: "mindfulness",
                          articleDetail: "a brief introduction into your brain",
                          isCompleted: true,
                          press: (){},
                        ),
                        infoArticle(
                          articleTitle: "stress",
                          articleDetail: "a brief introduction into your brain",
                          press: (){},
                        ),
                        infoArticle(
                          articleTitle: "anxiety",
                          articleDetail: "a brief introduction into your brain",
                          press: (){},
                        ),
                        infoArticle(
                          articleTitle: "depression",
                          articleDetail: "a brief introduction into your brain",
                          press: (){},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
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

