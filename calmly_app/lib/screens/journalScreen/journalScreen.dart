import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/components/smallButton.dart';
import 'package:flutter/material.dart';

class journalScreen extends StatefulWidget {
  @override
  _journalScreenState createState() => _journalScreenState();
}

class _journalScreenState extends State<journalScreen> {
  String _journalEntry = '';
  String _prompt = 'what are you grateful for today?';

  void _onJournalEntrySubmitted(String entry) {
    setState(() {
      _journalEntry = entry;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFFB1E6B1),
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
                      "journal",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      "express your thoughts",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Text(
                        "take a moment to reflect on your day and write down your thoughts to improve self-awareness.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF696969),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "today's prompt:",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _prompt,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                          color: Color(0xFF696969),
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        onChanged: (text) => _onJournalEntrySubmitted(text),
                        maxLines: 15,
                        maxLength: 1000,
                        decoration: InputDecoration(
                          hintText: "write your thoughts...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: smallButton(
                        buttonTitle: "save",
                        press: () {},
                      ),
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
