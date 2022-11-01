import 'package:flutter/material.dart';
import 'package:cell_calendar/cell_calendar.dart';
import 'package:shoplistapp/app/home/pages/calendar/sample_event.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2,
                  offset: Offset(3, 3),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const CellCalendarWidget()),
      ),
    );
  }
}

class CellCalendarWidget extends StatelessWidget {
  const CellCalendarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final samplesEvents = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();
    return CellCalendar(
      cellCalendarPageController: cellCalendarPageController,
      events: samplesEvents,
      daysOfTheWeekBuilder: (dayIndex) {
        final labels = ["S", "M", "T", "W", "T", "F", "S"];
        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            labels[dayIndex],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
      monthYearLabelBuilder: (datetime) {
        final year = datetime!.year.toString();
        final month = datetime.month.monthName;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Text(
                "$month  $year",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  cellCalendarPageController.animateToDate(
                    DateTime.now(),
                    curve: Curves.linear,
                    duration: const Duration(milliseconds: 300),
                  );
                },
              )
            ],
          ),
        );
      },
      onCellTapped: (date) {
        final eventsOnTheDate = samplesEvents.where((event) {
          final eventDate = event.eventDate;
          return eventDate.year == date.year &&
              eventDate.month == date.month &&
              eventDate.day == date.day;
        }).toList();
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("${date.month.monthName} ${date.day}"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: eventsOnTheDate
                        .map(
                          (event) => Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(4),
                            margin: const EdgeInsets.only(bottom: 12),
                            color: event.eventBackgroundColor,
                            child: Text(
                              event.eventName,
                              style: TextStyle(color: event.eventTextColor),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ));
      },
      onPageChanged: (firstDate, lastDate) {
        /// Called when the page was changed
        /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
      },
    );
  }
}
