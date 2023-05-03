import 'package:calmly_app/components/accountCheck.dart';
import 'package:calmly_app/components/inputField.dart';
import 'package:calmly_app/main.dart';
import 'package:calmly_app/screens/forgotPasswordScreen/components/forgotPasswordBackground.dart';
import 'package:calmly_app/screens/loginScreen/components/forgotPassword.dart';
import 'package:calmly_app/screens/loginScreen/components/loginBackground.dart';
import 'package:calmly_app/components/passwordField.dart';
import 'package:calmly_app/components/textField.dart';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/loginScreen/loginScreen.dart';
import 'package:calmly_app/screens/signupScreen/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class forgotPasswordBody extends StatefulWidget {
  const forgotPasswordBody({Key? key}) : super(key: key);

  @override
  _forgotPasswordBodyState createState() => _forgotPasswordBodyState();
}

class _forgotPasswordBodyState extends State<forgotPasswordBody> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return forgotPasswordBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "reset",
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
            Text(
              "password",
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
                controller: emailController,
                hintText: "email",
                icon: Icons.person,
                onChanged: (value) {},
              ),
            ),
            mainButton(
              buttonTitle: "RESET PASSWORD",
              press: () async {
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                    email: emailController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('password reset email sent. please check your email.')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return loginScreen();
                    }),
                  );
                } on FirebaseAuthException catch (e) {
                  print('error sending password reset email: ${e.code}');
                }
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
