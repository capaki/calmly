import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/components/searchBar.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/meditationScreen/components/meditationSession.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class meditationScreen extends StatefulWidget {
  @override
  _meditationScreenState createState() => _meditationScreenState();
}

class _meditationScreenState extends State<meditationScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  late final AudioCache audioCache;

  _meditationScreenState() {
    audioCache = AudioCache(prefix: 'assets/audio/', fixedPlayer: audioPlayer);
  }

  String? _currentPlayingFile;
  int? _currentPlayingSession;

  void playAudio(String fileName) async {
    if (_currentPlayingFile == fileName) {
      await audioPlayer.stop();
      _currentPlayingFile = null;
    } else {
      await audioPlayer.stop(); // Stop any currently playing audio
      await audioCache.play(fileName);
      _currentPlayingFile = fileName;
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
                      width: size.width * 0.6,
                      child: searchBar(),
                    ),
                    Wrap(
                      runSpacing: 15,
                      children: <Widget>[
                        meditationSession(
                          sessionNum: 0,
                          sessionTitle: "introduction",
                          press: () {
                            playAudio('birakmagendini.mp3');
                          },
                          sessionClicked: sessionClicked,
                          isPlaying: _currentPlayingSession == 0,
                        ),
                        meditationSession(
                          sessionNum: 1,
                          sessionTitle: "mindfulness",
                          press: () {
                            playAudio('digeryarim.mp3');
                          },
                          sessionClicked: sessionClicked,
                          isPlaying: _currentPlayingSession == 1,
                        ),
                        meditationSession(
                          sessionNum: 2,
                          sessionTitle: "stress",
                          press: () {
                            playAudio('stress.mp3');
                          },
                          sessionClicked: sessionClicked,
                          isPlaying: _currentPlayingSession == 2,
                        ),
                        meditationSession(
                          sessionNum: 3,
                          sessionTitle: "anxiety",
                          press: () {
                            playAudio('anxiety.mp3');
                          },
                          sessionClicked: sessionClicked,
                          isPlaying: _currentPlayingSession == 3,
                        ),
                        meditationSession(
                          sessionNum: 4,
                          sessionTitle: "rejection",
                          press: () {
                            playAudio('rejection.mp3');
                          },
                          sessionClicked: sessionClicked,
                          isPlaying: _currentPlayingSession == 4,
                        ),
                        meditationSession(
                          sessionNum: 5,
                          sessionTitle: "heartbreak",
                          press: () {
                            playAudio('heartbreak.mp3');
                          },
                          sessionClicked: sessionClicked,
                          isPlaying: _currentPlayingSession == 5,
                        ),
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