import 'dart:math';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class journalScreen extends StatefulWidget {
  @override
  _journalScreenState createState() => _journalScreenState();
}

class _journalScreenState extends State<journalScreen> {
  String _journalEntry = '';
  String _prompt = '';

  void _onJournalEntrySubmitted(String entry) {
    setState(() {
      _journalEntry = entry;
    });
  }

  Future<void> saveJournalEntry(String userId, String entry) async {
    final timestamp = Timestamp.now();
    final journalRef = FirebaseFirestore.instance.collection('journal');
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    await journalRef.add({
      'userId': userId,
      'timestamp': timestamp,
      'entry': entry,
      'prompt': _prompt,
    });

    final userDoc = await userRef.get();
    final int journalCount = userDoc.data()?['journalCount'] ?? 0;

    await userRef.update({'journalCount': journalCount + 1});
  }

  Future<void> _saveJournalEntry() async {
    if (_journalEntry.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please input your journal entry.'),
        ),
      );
      return;
    }

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await saveJournalEntry(currentUser.uid, _journalEntry);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Journal entry saved successfully.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please log in to save your journal entry.'),
        ),
      );
    }
  }

  Future<void> fetchRandomPrompt() async {
    final promptRef = FirebaseFirestore.instance.collection('prompts');
    final snapshot = await promptRef.get();
    final List<String> prompts =
        snapshot.docs.map((doc) => doc['prompt'] as String).toList();
    if (prompts.isNotEmpty) {
      final random = Random();
      final index = random.nextInt(prompts.length);
      setState(() {
        _prompt = prompts[index];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomPrompt();
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
                      "journal",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                    ),
                    SizedBox(height: 11),
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
                    SizedBox(height: 18),
                    Text(
                      "today's prompt:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Text(
                        _prompt,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF696969),
                        ),
                      ),
                    ),
                    SizedBox(height: 45),
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
                      child: mainButton(
                        buttonTitle: "SAVE",
                        press: _saveJournalEntry,
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
