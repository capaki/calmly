import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/components/searchBar.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/meditationScreen/components/meditationSession.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class meditationScreen extends StatefulWidget {
  @override
  _meditationScreenState createState() => _meditationScreenState();
}

class _meditationScreenState extends State<meditationScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  late final AudioCache audioCache;
  String searchQuery = '';

  _meditationScreenState() {
    audioCache = AudioCache(prefix: 'assets/audio/', fixedPlayer: audioPlayer);
  }

  String? _currentPlayingFile;
  int? _currentPlayingSession;

  void playAudio(String url) async {
    if (_currentPlayingFile == url) {
      await audioPlayer.stop();
      _currentPlayingFile = null;
    } else {
      await audioPlayer.stop();
      await audioPlayer.setUrl(url);
      await audioPlayer.play(url);
      _currentPlayingFile = url;
    }
  }

  void sessionClicked(int sessionNum) {
    setState(() {
      if (_currentPlayingSession == sessionNum) {
        _currentPlayingSession = null;
      } else {
        _currentPlayingSession = sessionNum;
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  Future<List<Widget>> getSessions() async {
  List<Widget> sessions = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await _firestore.collection('audios').orderBy('sessionNum').get();

  for (DocumentSnapshot doc in querySnapshot.docs) {
    final data = doc.data() as Map<String, dynamic>;
    sessions.add(
      meditationSession(
        sessionNum: data['sessionNum'] ?? 0,
        sessionTitle: data['sessionTitle'] ?? '',
        audioURL: data['audioURL'] ?? '',
        press: () {
          playAudio(data['audioURL'] ?? '');
        },
        sessionClicked: sessionClicked,
        isPlaying: _currentPlayingSession == data['sessionNum'],
      ),
    );
  }
  return sessions;
}

  Widget buildSessions(BuildContext context) {
  return FutureBuilder(
    future: getSessions(),
    builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Widget> sessions = snapshot.data!;
          List<Widget> filteredSessions = sessions.where((session) {
            if (session is meditationSession) {
              return session.sessionTitle.toLowerCase().contains(searchQuery);
            }
            return false;
          }).toList();
          return Wrap(runSpacing: 15, children: filteredSessions);
        }
      } else {
        return Container();
      }
    },
  );
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
              color: kBlueLightColor,
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
                      "meditation",
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
                      "take a moment to breathe",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
                          color: Color(0xFF696969),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: searchBar(
                        onChanged: updateSearchQuery,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildSessions(context),
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
