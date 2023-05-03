import 'package:calmly_app/main.dart';
import 'package:calmly_app/screens/welcomeScreen/components/welcomBackground.dart';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/loginScreen/loginScreen.dart';
import 'package:calmly_app/screens/signupScreen/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class welcomeBody extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return welcomeBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "welcome",
              style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF817DC0),
                  shadows: [
                    Shadow(
                      color: Color(0xFFC0C0C0),
                      offset: Offset(2, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.4,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            mainButton(
              buttonTitle: "LOG IN",
              press: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                    return loginScreen();
                    },
                  ),
                );
              },
            ),
            mainButton(
              buttonTitle: "SIGN UP",
              buttonColor: kPrimaryLightColor,
              titleColor: Colors.black,
              press: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                    return signupScreen();
                    },
                  ),
                );
              },
            ),
            mainButton(
              buttonTitle: "LOG OUT",
              press: () async {
                await FirebaseAuth.instance.signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('logged out successfully.')),
                );
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                    return HomePage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

