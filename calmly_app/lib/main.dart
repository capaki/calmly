import 'package:calmly_app/components.dart/navBarWidget.dart';
import 'package:calmly_app/components.dart/optionWidget.dart';
import 'package:calmly_app/components.dart/searchBarWidget.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/meditationScreen.dart';
import 'package:calmly_app/screens/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => welcomeScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size; //total height and width of the device
    return Scaffold(
      bottomNavigationBar: navBarWidget(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.45, // height of container is 45% of the device
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 70, 
                        width: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2BEA1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assets/icons/menu.svg"),
                      ),
                    ),
                    Text(
                      "stay calm",
                      style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    searchBarWidget(),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: <Widget>[
                          optionWidget(
                            optionTitle: "meditate",
                            svgSource: "assets/icons/Meditation.svg",
                            press: (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context){
                                  return meditationScreen();
                                }),
                              );
                            },
                          ),
                          optionWidget(
                            optionTitle: "journal",
                            svgSource: "assets/icons/Hamburger.svg",
                            press: (){}
                          ),
                          optionWidget(
                            optionTitle: "journal",
                            svgSource: "assets/icons/Hamburger.svg",
                            press: (){}
                          ),
                          optionWidget(
                            optionTitle: "educate",
                            svgSource: "assets/icons/Meditation.svg",
                            press: (){}
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

