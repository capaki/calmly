import 'dart:io';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/components/passwordField.dart';
import 'package:calmly_app/main.dart';
import 'package:calmly_app/screens/loginScreen/loginScreen.dart';
import 'package:calmly_app/screens/signupScreen/signupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/components/navBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class profileBody extends StatefulWidget {
  @override
  _profileBodyState createState() => _profileBodyState();
}

class _profileBodyState extends State<profileBody> {
  String? userName;
  String? userAge;
  String? userEmail;
  int? userMoodCount;
  int? journalEntryCount;
  DateTime? accountCreationDate;
  String? imageUrl;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserData();
    });
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        userName = doc['name'];
        userAge = doc['age'];
        userEmail = doc['email'];
        userMoodCount = doc['moodCount'];
        journalEntryCount = doc['journalCount'];
        accountCreationDate = doc['created_at'].toDate();
        _nameController.text = userName!;
        _ageController.text = userAge!;
        imageUrl = doc['imageUrl'];
      });
    }
  }

  Future<void> updateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      int newAge = int.parse(_ageController.text);
      if (newAge < 16) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You must be at least 16 years old.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        _ageController.text = userAge!;
        return;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'name': _nameController.text,
        'age': _ageController.text,
      });
      getUserData();
    }
  }

  Future<bool> _verifyPassword(String password) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      EmailAuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      ) as EmailAuthCredential;
      try {
        await user.reauthenticateWithCredential(credential);
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  Future<void> _deleteAccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();
      await user.delete();
    }
  }

  void _showPasswordVerificationDialog(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 16,
          child: Container(
            height: 420,
            width: 550,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Account Deletion',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kBlueColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'We are sorry to see you go!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Please enter your password to confirm deletion.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  passwordField(
                    controller: passwordController,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 4),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      mainButton(
                        buttonTitle: 'DELETE ACCOUNT',
                        press: () async {
                          String password = passwordController.text.trim();
                          bool verified = await _verifyPassword(password);
                          if (verified) {
                            _deleteAccount();
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Account deleted successfully.'),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Invalid password. Please try again.'),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(width: 5),
                      mainButton(
                        buttonTitle: 'CANCEL',
                        press: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> updateUserImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'imageUrl': imageFile.path});

        setState(() {
          imageUrl = imageFile.path;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: Builder(
        builder: (BuildContext scaffoldContext) {
          return SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: size.height * .35,
                    decoration: BoxDecoration(
                      color: Color(0xFF84AB5C),
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Stack(
                              children: [
                                Container(
                                  height: size.height * 0.35,
                                  width: size.width * 0.35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                    image: imageUrl != null &&
                                            imageUrl!.isNotEmpty
                                        ? DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: FileImage(File(imageUrl!)),
                                          )
                                        : DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: AssetImage(
                                                "assets/images/anonymous.jpg"),
                                          ),
                                  ),
                                ),
                                Positioned(
                                  top: 185,
                                  right: 5,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 23,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 28,
                                        color: kBlueColor,
                                      ),
                                      onPressed: () {
                                        updateUserImage();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (userName != null)
                            displayInfoCard("name:", userName!),
                          if (userAge != null)
                            displayInfoCard("age:", userAge!),
                          if (userEmail != null)
                            displayInfoCard("email:", userEmail!),
                          if (accountCreationDate != null)
                            displayInfoCard(
                              "joined on:",
                              DateFormat.yMMMMd('en_US')
                                  .format(accountCreationDate!),
                            ),
                          if (userMoodCount != null)
                            displayInfoCard(
                                "moods tracked:", userMoodCount.toString()),
                          if (journalEntryCount != null)
                            displayInfoCard("journal entries:",
                                journalEntryCount.toString()),
                          if (currentUser != null)
                            Column(
                              children: [
                                mainButton(
                                  buttonTitle: "EDIT DETAILS",
                                  buttonColor: kPrimaryLightColor,
                                  titleColor: Colors.black,
                                  press: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          elevation: 16,
                                          child: Container(
                                            height: 420,
                                            width: 550,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'Edit Profile',
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: kBlueColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    TextField(
                                                      controller:
                                                          _nameController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Name',
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    TextField(
                                                      controller:
                                                          _ageController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Age',
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15.0), // Sets the TextField's border radius
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    mainButton(
                                                      buttonTitle: "SAVE",
                                                      press: () {
                                                        updateUserData();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    SizedBox(height: 3),
                                                    mainButton(
                                                      buttonTitle: "CANCEL",
                                                      press: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                SizedBox(height: 5),
                                mainButton(
                                  buttonTitle: "LOG OUT",
                                  press: () async {
                                    await FirebaseAuth.instance.signOut();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Logged out successfully.'),
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return HomePage();
                                        },
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 5),
                                mainButton(
                                  buttonTitle: "DELETE ACCOUNT",
                                  buttonColor: kPrimaryLightColor,
                                  titleColor: Colors.black,
                                  press: () {
                                    _showPasswordVerificationDialog(context);
                                  },
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                mainButton(
                                  buttonTitle: "LOG IN",
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
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
                                        builder: (context) {
                                          return signupScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget displayInfoCard(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kBlueColor,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
