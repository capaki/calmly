import 'package:calmly_app/components.dart/accountCheck.dart';
import 'package:calmly_app/components.dart/button.dart';
import 'package:calmly_app/components.dart/inputField.dart';
import 'package:calmly_app/screens/signupScreen/components/orDivider.dart';
import 'package:calmly_app/components.dart/passwordField.dart';
import 'package:calmly_app/screens/signupScreen/components/signupBackground.dart';
import 'package:calmly_app/screens/signupScreen/components/socialMedia.dart';
import 'package:calmly_app/components.dart/textField.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/loginScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class signupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return signupBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "sign up",
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
              "assets/icons/signup.svg",
              height: size.height * 0.3,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            textField(
              child: inputField(
                hintText: "email",
                icon: Icons.person,
                onChanged: (value) {},
              ),
            ),
            passwordField(
              onChanged: (value){},
            ),
            mainButton(
              buttonTitle: "SIGN UP",
              press: () {},
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            accountCheck(
              login: false,
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
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                socialMedia(
                  iconPath: "assets/icons/twitter.svg",
                  press: () {},
                ),
                socialMedia(
                  iconPath: "assets/icons/google-plus.svg",
                  press: () {},
                ),
                socialMedia(
                  iconPath: "assets/icons/facebook.svg",
                  press: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

