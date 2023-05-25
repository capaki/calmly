import 'package:calmly_app/components/inputField.dart';
import 'package:calmly_app/screens/forgotPasswordScreen/components/forgotPasswordBackground.dart';
import 'package:calmly_app/components/textField.dart';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/screens/loginScreen/loginScreen.dart';
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
            Text(
              "password",
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
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.38,
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
                    SnackBar(
                      content: Text(
                        'Password reset email sent. Please check your email.',
                      ),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return loginScreen();
                    }),
                  );
                } on FirebaseAuthException catch (e) {
                  String errorMessage = '';
                  if (e.code == 'user-not-found') {
                    errorMessage = 'User does not exist.';
                  } else if (e.code == 'invalid-email') {
                    errorMessage = 'Invalid email address.';
                  } else {
                    print('Error sending password reset email: ${e.code}');
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
          ],
        ),
      ),
    );
  }
}
