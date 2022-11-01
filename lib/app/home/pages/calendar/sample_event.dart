import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

List<CalendarEvent> sampleEvents() {
  final today = DateTime.now();
  // final eventTextStyle = const TextStyle(
  //   fontSize: 9,
  //   color: Colors.white,
  // );
  final sampleEvents = [
    CalendarEvent(
      eventName: "New iPhone",
      eventDate: today.add(const Duration(days: -42)),
      eventBackgroundColor: Colors.black,
    ),
    CalendarEvent(
      eventName: "Writing test",
      eventDate: today.add(const Duration(days: -30)),
      eventBackgroundColor: Colors.deepOrange,
    ),
    CalendarEvent(
      eventName: "Play soccer",
      eventDate: today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.greenAccent,
    ),
    CalendarEvent(
      eventName: "Learn about history",
      eventDate: today.add(
        const Duration(days: -7),
      ),
    ),
    CalendarEvent(
      eventName: "Buy new keyboard",
      eventDate: today.add(
        const Duration(days: -7),
      ),
    ),
    CalendarEvent(
      eventName: "Walk around the park",
      eventDate: today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.deepOrange,
    ),
    CalendarEvent(
      eventName: "Buy a present for Rebecca",
      eventDate: today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.pink,
    ),
    CalendarEvent(
      eventName: "Firebase",
      eventDate: today.add(
        const Duration(days: -7),
      ),
    ),
    CalendarEvent(
      eventName: "Task deadline",
      eventDate: today,
    ),
    CalendarEvent(
      eventName: "Jon's Birthday",
      eventDate: today.add(
        const Duration(days: 3),
      ),
      eventBackgroundColor: Colors.green,
    ),
    CalendarEvent(
      eventName: "Date with Rebecca",
      eventDate: today.add(const Duration(days: 7)),
      eventBackgroundColor: Colors.pink,
    ),
    CalendarEvent(
      eventName: "Start to study Spanish",
      eventDate: today.add(
        const Duration(days: 13),
      ),
    ),
    CalendarEvent(
      eventName: "Have lunch with Mike",
      eventDate: today.add(const Duration(days: 13)),
      eventBackgroundColor: Colors.green,
    ),
    CalendarEvent(
      eventName: "Buy new Play Station software",
      eventDate: today.add(const Duration(days: 13)),
      eventBackgroundColor: Colors.indigoAccent,
    ),
    CalendarEvent(
      eventName: "Update my flutter package",
      eventDate: today.add(
        const Duration(days: 13),
      ),
    ),
    CalendarEvent(
      eventName: "Watch movies in my house",
      eventDate: today.add(
        const Duration(days: 21),
      ),
    ),
    CalendarEvent(
      eventName: "Medical Checkup",
      eventDate: today.add(const Duration(days: 30)),
      eventBackgroundColor: Colors.red,
    ),
    CalendarEvent(
      eventName: "Gym",
      eventDate: today.add(const Duration(days: 42)),
      eventBackgroundColor: Colors.indigoAccent,
    ),
  ];
  return sampleEvents;
}
