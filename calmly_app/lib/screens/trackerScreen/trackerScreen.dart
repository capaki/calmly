import 'package:calmly_app/components.dart/navBar.dart';
import 'package:calmly_app/components.dart/searchBar.dart';
import 'package:calmly_app/components.dart/button.dart';
import 'package:calmly_app/components.dart/smallButton.dart';
import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

/*class trackerScreen extends StatelessWidget{
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
              color: Color(0xFFADD8E6),
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
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "daily tracker",
                      style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "get to know your mind better",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Text(
                        "live happier and healthier by learning the fundamentals of meditation and mindfulness through practice.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8F8F8F),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Text(
                        "take a deep breath, god knows you need it.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8F8F8F),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: searchBar(),
                    ),
                    Wrap(
                      runSpacing: 15,
                      children: <Widget>[

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
*/

import 'package:flutter/material.dart';

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
              color: Color(0xFFADD8E6),
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
                      style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(
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
                    SizedBox(height: 25),
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
                                  offset: Offset(0, 15),
                                  blurRadius: 23,
                                  spreadRadius: -20,
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding( // Wrap the Icon widget with a Padding widget
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1), // Set the desired padding
                                  child: Icon(
                                    moodData['icon'],
                                    color: isSelected ? kPrimaryColor : Colors.grey, // Set the color to kPrimaryColor when selected
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
                    SizedBox(height: 25),
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
                          hintText: "do you want to elaborate on why you might be feeling this way?",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),                    
                    Align(
                      alignment: Alignment.bottomCenter, // Position the button at the bottom right
                      child: smallButton(
                        buttonTitle: "save",
                        press: () {},
                      )
                    ),
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

