import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsList extends StatelessWidget {
  final List<Map<String, dynamic>> events;

  const EventsList({required this.events, Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final moodDetails = getMoodDetails(event['mood'] ?? '');
        final moodColor = moodDetails['color'] as Color;
        final moodIcon = moodDetails['icon'] as IconData;
        return ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            color: Color(0xFFF5F5F5),
            child: ListTile(
              title: Text(event['mood'] ?? ''),
              subtitle: Text(event['reason'] ?? ''),
              leading: CircleAvatar(
                backgroundColor: moodColor,
                child: Icon(
                  moodIcon,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
