import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/components/option.dart';
import 'package:calmly_app/components/quoteBox.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/infoScreen/infoScreen.dart';
import 'package:calmly_app/screens/meditationScreen/meditationScreen.dart';
import 'package:calmly_app/screens/openingScreen/openingScreen.dart';
import 'package:calmly_app/screens/trackerScreen/trackerScreen.dart';
import 'package:calmly_app/screens/journalScreen/journalScreen.dart';
import 'package:calmly_app/screens/profileScreen/profileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/': (context) => openingScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size =
        MediaQuery.of(context).size; //total height and width of the device
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height:
                size.height * 0.45, // height of container is 45% of the device
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2BEA1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assets/icons/menu.svg"),
                      ),
                    ),
                  ),
                  Text(
                    "stay calm.",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                  ),
                  QuoteBox(),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 15,
                      children: <Widget>[
                        option(
                          optionTitle: "meditate",
                          svgSource: "assets/icons/Meditation.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return meditationScreen();
                              }),
                            );
                          },
                        ),
                        option(
                            optionTitle: "journal",
                            svgSource: "assets/icons/Meditation.svg",
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return journalScreen();
                                }),
                              );
                            }),
                        option(
                            optionTitle: "daily tracker",
                            svgSource: "assets/icons/Meditation.svg",
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return trackerScreen();
                                }),
                              );
                            }),
                        option(
                            optionTitle: "get informed",
                            svgSource: "assets/icons/Meditation.svg",
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return infoScreen();
                                }),
                              );
                            }),
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
