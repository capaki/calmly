import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/components/searchBar.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/infoScreen/components/articleScreen.dart';
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
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Text(
                        "dive deep into the complex parts of the human brain. learn how your brain functions under various emotions such as stress, anxiety, happiness etc",
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
                          articleDetail: "a bried introduction into your brain",
                          articleKey: "introduction",
                          press: (){
                           Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context){
                              return articleScreen(articleKey: "introduction");
                            }),
                          );
                        },
                        ),
                        infoArticle(
                          articleTitle: "mindfulness",
                          articleDetail: "a brief introduction into your brain",
                          articleKey: "mindfulness",
                          press: (){
                           Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context){
                              return articleScreen(articleKey: "mindfulness");
                            }),
                          );
                        },
                        ),
                        infoArticle(
                          articleTitle: "stress",
                          articleDetail: "a brief introduction into your brain",
                          articleKey: "stress",
                          press: (){
                           Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context){
                              return articleScreen(articleKey: "stress");
                            }),
                          );
                        },
                        ),
                        infoArticle(
                          articleTitle: "anxiety",
                          articleDetail: "a brief introduction into your brain",
                          articleKey: "anxiety",
                          press: (){
                           Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context){
                              return articleScreen(articleKey: "anxiety");
                            }),
                          );
                        },
                        ),
                        infoArticle(
                          articleTitle: "depression",
                          articleDetail: "a brief introduction into your brain",
                          articleKey: "depression",
                          press: (){
                           Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context){
                              return articleScreen(articleKey: "depression");
                            }),
                          );
                        },
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

