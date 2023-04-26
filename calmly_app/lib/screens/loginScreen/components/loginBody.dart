import 'package:calmly_app/components/accountCheck.dart';
import 'package:calmly_app/components/inputField.dart';
import 'package:calmly_app/main.dart';
import 'package:calmly_app/screens/loginScreen/components/loginBackground.dart';
import 'package:calmly_app/components/passwordField.dart';
import 'package:calmly_app/components/textField.dart';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/signupScreen/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class loginBody extends StatelessWidget {
  const loginBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loginBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "log in",
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
              "assets/icons/login.svg",
              height: size.height * 0.33,
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
              buttonTitle: "LOG IN",
              press: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context){
                    return HomePage();
                  }),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            accountCheck(
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
          ],
        ),
      ),
    );
  }
}

