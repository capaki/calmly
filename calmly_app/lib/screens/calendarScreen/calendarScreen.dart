import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/calendarScreen/components/EventsList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class calendarScreen extends StatefulWidget {
  @override
  _calendarScreenState createState() => _calendarScreenState();
}

class _calendarScreenState extends State<calendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Map<String, dynamic>>> _selectedEvents;
  late final ValueNotifier<Color> _selectedDayColor;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay, {}));
    _selectedDayColor = ValueNotifier(kPrimaryColor);
  }


  @override
  void dispose() {
    _selectedEvents.dispose();
    _selectedDayColor.dispose();
    super.dispose();
  }

  Map<String, dynamic> getMoodDetails(String mood) {
    switch (mood) {
      case 'awesome':
        return {'color': Colors.green[800] ?? Colors.green};
      case 'good':
        return {'color': Colors.green};
      case 'okay':
        return {'color': Colors.yellow};
      case 'bad':
        return {'color': Colors.orange};
      case 'terrible':
        return {'color': Colors.red};
      default:
        return {'color': Colors.grey};
    }
  }

  Future<Map<DateTime, List<Map<String, dynamic>>>> fetchMoodData({
    required VoidCallback onUserNotSignedIn,
  }) async {
    Map<DateTime, List<Map<String, dynamic>>> moodData = {};

    if (FirebaseAuth.instance.currentUser == null) {
      onUserNotSignedIn();
      return moodData;
    }

    String userId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('moodTracker')
        .where('userId', isEqualTo: userId)
        .get();

    for (DocumentSnapshot doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      DateTime date = (data['timestamp'] as Timestamp).toDate();
      DateTime key = DateTime(date.year, date.month, date.day);
      String mood = data['mood'] ?? '';
      String reason = data['reason'] ?? '';

      if (!moodData.containsKey(key)) {
        moodData[key] = [];
      }

      (moodData[key] ??= []).add({'mood': mood, 'reason': reason});
    }

    return moodData;
  }

  List<Map<String, dynamic>> _getEventsForDay(
      DateTime day, Map<DateTime, List<Map<String, dynamic>>> moodData) {
    List<Map<String, dynamic>> events = moodData[day] ?? [];

    return events;
  }

    @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.45, 
            decoration: BoxDecoration(
              color: Color(0xFFC0C0C0),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
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
                      "calendar",
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: size.height * 0.70, 
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Builder(
                            builder: (BuildContext context) {
                              return FutureBuilder(
                                future: fetchMoodData(
                                  onUserNotSignedIn: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('please login to access your data.')),
                                    );
                                  },
                                ),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Map<DateTime, List<Map<String, dynamic>>>> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  }

                                  Map<DateTime, List<Map<String, dynamic>>> moodData = snapshot.data ?? {};

                                  return Column(
                                    children: [
                                      TableCalendar(
                                        firstDay: DateTime.utc(2023, 1, 1),
                                        lastDay: DateTime.utc(2030, 12, 31),
                                        focusedDay: _focusedDay,
                                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                                        calendarFormat: _calendarFormat,
                                        onFormatChanged: (format) {
                                          setState(() {
                                            _calendarFormat = format;
                                          });
                                        },
                                        eventLoader: (day) => _getEventsForDay(day, moodData),
                                        onPageChanged: (focusedDay) {
                                          _focusedDay = focusedDay;
                                        },
                                        onDaySelected: (selectedDay, focusedDay) {
                                          setState(() {
                                            _selectedDay = selectedDay;
                                            _focusedDay = focusedDay;
                                            DateTime localSelectedDay =
                                                DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                                            _selectedEvents.value = _getEventsForDay(localSelectedDay, moodData);
                                          });
                                        },
                                        calendarStyle: CalendarStyle(
                                          selectedDecoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: () {
                                              if (_selectedDay != null &&
                                                  _getEventsForDay(_selectedDay!, moodData).isNotEmpty) {
                                                var color = getMoodDetails(
                                                    _getEventsForDay(_selectedDay!, moodData).first['mood'] ?? '')['color'];
                                                return color;
                                              } else {
                                                return kPrimaryColor;
                                              }
                                            }(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ValueListenableBuilder<List<Map<String, dynamic>>>(
                                        valueListenable: _selectedEvents,
                                        builder: (context, value, _) {
                                          return EventsList(events: value);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          ),
                        ),
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


