import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class trackerScreen extends StatefulWidget {
  @override
  _trackerScreenState createState() => _trackerScreenState();
}

class _trackerScreenState extends State<trackerScreen> {
  String _selectedMood = '';
  String _moodReason = '';

  List<Map<String, dynamic>> _moods = [
    {'label': 'awesome', 'icon': Icons.wb_sunny},
    {'label': 'good', 'icon': Icons.mood},
    {'label': 'okay', 'icon': Icons.account_circle},
    {'label': 'bad', 'icon': Icons.mood_bad},
    {'label': 'terrible', 'icon': Icons.wb_cloudy},
  ];

  void _onMoodSelected(String mood) {
    setState(() {
      _selectedMood = mood;
    });
  }

  void _onReasonSubmitted(String reason) {
    setState(() {
      _moodReason = reason;
    });
  }

  void _saveMoodTrackerData() async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('please login to track your mood.')),
        );
        return;
      }

      String userId = FirebaseAuth.instance.currentUser!.uid;
      DateTime today = DateTime.now();
      DateTime startOfDay = DateTime(today.year, today.month, today.day);
      DateTime endOfDay = DateTime(today.year, today.month, today.day + 1);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('moodTracker')
          .where('userId', isEqualTo: userId)
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThan: endOfDay)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('you have already tracked your mood for today.')),
        );
        return;
      }

      await FirebaseFirestore.instance.collection('moodTracker').add({
        'mood': _selectedMood,
        'reason': _moodReason,
        'timestamp': DateTime.now(),
        'userId': userId,
      });

      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userDoc);

        if (!snapshot.exists) {
          throw Exception("User does not exist!");
        }

        int newMoodCount = snapshot.get('moodCount') + 1;
        transaction.update(userDoc, {'moodCount': newMoodCount});
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('mood saved successfully.')),
      );

      print('Mood tracker data saved successfully!');
    } catch (e) {
      print('Error saving mood tracker data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFF9CC8BC),
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.05),
                    Text(
                      "mood tracker",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "how are you feeling today?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: _moods.map<Widget>((moodData) {
                        bool isSelected = _selectedMood == moodData['label'];
                        return InkWell(
                          onTap: () => _onMoodSelected(moodData['label']),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 25,
                                  spreadRadius: -20,
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  // Wrap the Icon widget with a Padding widget
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 1), // Set the desired padding
                                  child: Icon(
                                    moodData['icon'],
                                    color: isSelected
                                        ? kPrimaryColor
                                        : Colors
                                            .grey, // Set the color to kPrimaryColor when selected
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  moodData['label'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: isSelected
                                        ? kPrimaryColor
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "why are you feeling this way?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        onChanged: (text) => _onReasonSubmitted(text),
                        maxLines: 5,
                        maxLength: 300,
                        decoration: InputDecoration(
                          hintText:
                              "do you want to elaborate on why you might be feeling this way?",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment
                            .bottomCenter, // Position the button at the bottom right
                        child: mainButton(
                          buttonTitle: "SAVE  MOOD",
                          press: () {
                            _saveMoodTrackerData();
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
