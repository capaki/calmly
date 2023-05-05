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

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay, {}));
  }


  @override
  void dispose() {
    _selectedEvents.dispose();
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


  Future<Map<DateTime, List<Map<String, dynamic>>>> fetchMoodData() async {
    Map<DateTime, List<Map<String, dynamic>>> moodData = {};

    if (FirebaseAuth.instance.currentUser == null) {
      return moodData;
    }

    String userId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('moodTracker')
        .where('userId', isEqualTo: userId)
        .get();

    print('Number of documents fetched: ${querySnapshot.docs.length}'); 

    for (DocumentSnapshot doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      DateTime date = (data['timestamp'] as Timestamp).toDate();
      DateTime key = DateTime(date.year, date.month, date.day);
      String mood = data['mood'] ?? '';
      String reason = data['reason'] ?? '';

      print('Date: $key, Mood: $mood, Reason: $reason'); 

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
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FutureBuilder(
              future: fetchMoodData(),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<DateTime, List<Map<String, dynamic>>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                Map<DateTime, List<Map<String, dynamic>>> moodData = snapshot.data ?? {};

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TableCalendar(
                        firstDay: DateTime.utc(2023, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: () {
                              if (_selectedDay != null && _getEventsForDay(_selectedDay!, moodData).isNotEmpty) {
                                var color = getMoodDetails(_getEventsForDay(_selectedDay!, moodData).first['mood'] ?? '')['color'];
                                print('Selected day: $_selectedDay, Mood: ${_getEventsForDay(_selectedDay!, moodData).first['mood']}, Color: $color');
                                return color;
                              } else {
                                return kPrimaryColor;
                              }
                            }(),
                          ),

                        ),
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
                            DateTime localSelectedDay = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                            _selectedEvents.value = _getEventsForDay(localSelectedDay, moodData); 
                          });
                        },
                      ),
                      EventsList(events: _selectedEvents.value),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}