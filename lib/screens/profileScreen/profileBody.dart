import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/components/smallButton.dart';
import 'package:calmly_app/main.dart';
import 'package:calmly_app/screens/loginScreen/loginScreen.dart';
import 'package:calmly_app/screens/signupScreen/signupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/components/navBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  DateTime? accountCreationDate;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
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
        accountCreationDate = doc['created_at'].toDate();
        _nameController.text = userName!;
        _ageController.text = userAge!;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('please login to see your information.')),
      );
    }
  }

  Future<void> updateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      int newAge = int.parse(_ageController.text);
      if (newAge < 16) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You must be at least 16 years old.')),
        );
        _ageController.text =
            userAge!; // Reset the age controller to the current age
        return;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'name': _nameController.text,
        'age': _ageController.text,
      });
      getUserData(); // Refresh the user data
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: SingleChildScrollView(
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
                        padding: const EdgeInsets.only(top: 30),
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
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage("assets/images/pic2.png"),
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
                                    size: 28, // Adjust the icon size as needed
                                    color:
                                        kBlueColor, // Set the desired icon color
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                25.0), // Sets the dialog's border radius
                                          ),
                                          elevation: 16,
                                          child: Container(
                                            height: 400,
                                            width: 580,
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
                                                    SizedBox(height: 24),
                                                    TextField(
                                                      controller:
                                                          _nameController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Name',
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15.0), // Sets the TextField's border radius
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 16),
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
                                                    SizedBox(height: 16),
                                                    mainButton(
                                                      buttonTitle: "cancel",
                                                      press: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    SizedBox(height: 5),
                                                    mainButton(
                                                      buttonTitle: "save",
                                                      press: () {
                                                        updateUserData();
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (userName != null) displayInfoCard("name", userName!),
                      if (userAge != null) displayInfoCard("age", userAge!),
                      if (userEmail != null)
                        displayInfoCard("email", userEmail!),
                      if (accountCreationDate != null)
                        displayInfoCard(
                          "joined on",
                          DateFormat.yMMMMd('en_US')
                              .format(accountCreationDate!),
                        ),
                      if (userMoodCount != null)
                        displayInfoCard(
                            "moods tracked", userMoodCount.toString()),
                      if (currentUser != null)
                        mainButton(
                          buttonTitle: "LOG OUT",
                          press: () async {
                            await FirebaseAuth.instance.signOut();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('logged out successfully.')),
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
