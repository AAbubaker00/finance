import 'package:flutter/material.dart';
import 'package:calendar_strip/calendar_strip.dart' as cs;

class Dividend extends StatefulWidget {
  @override
  _DividendState createState() => _DividendState();
}

class _DividendState extends State<Dividend> {
  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.now().subtract(Duration(days: 2));
  DateTime endDate = DateTime.now().add(Duration(days: 2));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 2));
  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: cs.CalendarStrip()
              
            )
          ],
        )
      ),
    );
  }
}
