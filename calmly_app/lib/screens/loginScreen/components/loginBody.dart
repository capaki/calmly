import 'package:calmly_app/components/accountCheck.dart';
import 'package:calmly_app/components/inputField.dart';
import 'package:calmly_app/main.dart';
import 'package:calmly_app/screens/loginScreen/components/forgotPassword.dart';
import 'package:calmly_app/screens/loginScreen/components/loginBackground.dart';
import 'package:calmly_app/components/passwordField.dart';
import 'package:calmly_app/components/textField.dart';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/screens/forgotPasswordScreen/forgotPasswordScreen.dart';
import 'package:calmly_app/screens/signupScreen/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginBody extends StatefulWidget {
  const loginBody({Key? key}) : super(key: key);

  @override
  _loginBodyState createState() => _loginBodyState();
}

class _loginBodyState extends State<loginBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
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
            passwordField(
              controller: passwordController,
              onChanged: (value) {},
            ),
            ForgotPassword(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return forgotPasswordScreen();
                    },
                  ),
                );
              },
            ),
            mainButton(
              buttonTitle: "LOG IN",
              press: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logged in successfully.')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }),
                  );
                } on FirebaseAuthException catch (e) {
                  String errorMessage = '';
                  if (e.code == 'user-not-found' ||
                      e.code == 'wrong-password') {
                    errorMessage = 'Wrong email or password.';
                  } else if (e.code == 'invalid-email') {
                    errorMessage = 'Invalid email address.';
                  } else {
                    print('Error signing in: ${e.code}');
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        errorMessage,
                      ),
                    ),
                  );
                }
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
                    builder: (context) {
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
