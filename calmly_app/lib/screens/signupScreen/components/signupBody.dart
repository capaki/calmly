import 'package:calmly_app/components/accountCheck.dart';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/components/inputField.dart';
import 'package:calmly_app/components/passwordField.dart';
import 'package:calmly_app/screens/signupScreen/components/signupBackground.dart';
import 'package:calmly_app/components/textField.dart';
import 'package:calmly_app/screens/loginScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signupBody extends StatefulWidget {
  @override
  _signupBodyState createState() => _signupBodyState();
}

class _signupBodyState extends State<signupBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Future<void> addUserToFirestore(
      String uid, String name, String email, String age) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.doc(uid).set({
      'name': name,
      'email': email,
      'age': age,
      'created_at': DateTime.now(),
      'moodCount': 0,
      'journalCount': 0,
    });
  }

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
            textField(
              child: inputField(
                controller: _nameController,
                hintText: "name",
                icon: Icons.person,
                onChanged: (value) {},
              ),
            ),
            textField(
              child: inputField(
                controller: _ageController,
                hintText: "age",
                icon: Icons.cake,
                onChanged: (value) {},
              ),
            ),
            textField(
              child: inputField(
                controller: _emailController,
                hintText: "email",
                icon: Icons.email,
                onChanged: (value) {},
              ),
            ),
            passwordField(
              controller: _passwordController,
              onChanged: (value) {},
            ),
            mainButton(
              buttonTitle: "SIGN UP",
              press: () async {
                if (int.parse(_ageController.text) < 16) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'You must be at least 16 years old to create an account.')),
                  );
                  return;
                }
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  await addUserToFirestore(
                    userCredential.user!.uid,
                    _nameController.text,
                    _emailController.text,
                    _ageController.text,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return loginScreen();
                    }),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Account created successfully. Please log in.')),
                  );
                } on FirebaseAuthException catch (e) {
                  String errorMessage;
                  switch (e.code) {
                    case 'email-already-in-use':
                      errorMessage = 'The email address is already in use.';
                      break;
                    case 'invalid-email':
                      errorMessage = 'Invalid email address.';
                      break;
                    case 'weak-password':
                      errorMessage = 'The password is too weak.';
                      break;
                    default:
                      errorMessage =
                          'An error occurred. Please try again later.';
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
                  print('Error signing up: ${e.code}');
                }
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            accountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return loginScreen();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
