import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/constants.dart';
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
        return {
          'color': Colors.green[800] ?? Colors.green,
          'icon': Icons.wb_sunny,
        };
      case 'good':
        return {
          'color': Colors.green,
          'icon': Icons.mood,
        };
      case 'okay':
        return {
          'color': Colors.yellow,
          'icon': Icons.account_circle,
        };
      case 'bad':
        return {
          'color': Colors.orange,
          'icon': Icons.mood_bad,
        };
      case 'terrible':
        return {
          'color': Colors.red,
          'icon': Icons.wb_cloudy,
        };
      default:
        return {
          'color': Colors.grey,
          'icon': Icons.help,
        };
    }
  }

  Future<Map<DateTime, List<Map<String, dynamic>>>> fetchJournalData({
    required VoidCallback onUserNotSignedIn,
  }) async {
    Map<DateTime, List<Map<String, dynamic>>> journalData = {};

    if (FirebaseAuth.instance.currentUser == null) {
      onUserNotSignedIn();
      return journalData;
    }

    String userId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('journal')
        .where('userId', isEqualTo: userId)
        .get();

    for (DocumentSnapshot doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      DateTime date = (data['timestamp'] as Timestamp).toDate();
      DateTime key = DateTime(date.year, date.month, date.day);
      String entry = data['entry'] ?? '';

      if (!journalData.containsKey(key)) {
        journalData[key] = [];
      }

      (journalData[key] ??= []).add({'entry': entry});
    }

    return journalData;
  }

  List<Map<String, dynamic>> _getEventsForDay(
      DateTime day, Map<DateTime, List<Map<String, dynamic>>> journalData) {
    List<Map<String, dynamic>> events = journalData[day] ?? [];

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
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                future: fetchJournalData(
                                  onUserNotSignedIn: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Please log in to access your data.')),
                                    );
                                  },
                                ),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            Map<DateTime,
                                                List<Map<String, dynamic>>>>
                                        snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }

                                  Map<DateTime, List<Map<String, dynamic>>>
                                      journalData = snapshot.data ?? {};

                                  return Column(
                                    children: [
                                      TableCalendar(
                                        firstDay: DateTime.utc(2023, 1, 1),
                                        lastDay: DateTime.utc(2030, 12, 31),
                                        focusedDay: _focusedDay,
                                        selectedDayPredicate: (day) =>
                                            isSameDay(_selectedDay, day),
                                        calendarFormat: _calendarFormat,
                                        onFormatChanged: (format) {
                                          setState(() {
                                            _calendarFormat = format;
                                          });
                                        },
                                        eventLoader: (day) =>
                                            _getEventsForDay(day, journalData),
                                        onPageChanged: (focusedDay) {
                                          _focusedDay = focusedDay;
                                        },
                                        onDaySelected:
                                            (selectedDay, focusedDay) {
                                          setState(() {
                                            _selectedDay = selectedDay;
                                            _focusedDay = focusedDay;
                                            DateTime localSelectedDay =
                                                DateTime(
                                                    selectedDay.year,
                                                    selectedDay.month,
                                                    selectedDay.day);
                                            _selectedEvents.value =
                                                _getEventsForDay(
                                                    localSelectedDay,
                                                    journalData);
                                          });
                                        },
                                        calendarStyle: CalendarStyle(
                                          selectedDecoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: () {
                                              if (_selectedDay != null &&
                                                  _getEventsForDay(
                                                          _selectedDay!,
                                                          journalData)
                                                      .isNotEmpty) {
                                                return kPrimaryColor;
                                              } else {
                                                return _selectedDayColor.value;
                                              }
                                            }(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ValueListenableBuilder<
                                          List<Map<String, dynamic>>>(
                                        valueListenable: _selectedEvents,
                                        builder: (context, value, _) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: value.length,
                                            itemBuilder: (context, index) {
                                              final event = value[index];
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                child: Card(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 8.0),
                                                  color: Color(0xFFF5F5F5),
                                                  child: ListTile(
                                                    title: Text(
                                                        event['entry'] ?? ''),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
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
