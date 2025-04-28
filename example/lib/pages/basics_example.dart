// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:table_calendar_example/utils.dart';

class TableBasicsExample extends StatefulWidget {
  const TableBasicsExample({super.key});

  @override
  State<TableBasicsExample> createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TableCalendar - Basics'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: TableCalendar(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          rowHeight: 76,
          // headerVisible: false,
          pageAnimationEnabled: false,
          pointCount: '20',
          calendarStyle: CalendarStyle(
              cellMargin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              defaultDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E5E5), width: 1)),
              defaultTextStyle:
                  const TextStyle(fontSize: 14, color: Color(0xFF333333)),
              defaultSubTextStyle:
                  TextStyle(fontSize: 8, color: Color(0xFF33333366)),
              selectedDecoration: BoxDecoration(
                  color: const Color(0xFFF2FFF3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFC7F4EA), width: 1)),
              selectedTextStyle:
                  const TextStyle(fontSize: 14, color: Color(0xFF3E8590)),
              selectedSubTextStyle:
                  TextStyle(fontSize: 8, color: Color(0xFF6AB9C5)),
              todayDecoration: BoxDecoration(
                  color: const Color(0xFFFEF5F4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFFDC6C0), width: 1)),
              todayTextStyle:
                  const TextStyle(fontSize: 14, color: Color(0xFF333333)),
              todaySubTextStyle:
                  TextStyle(fontSize: 8, color: Color(0xFF33333366)),
              weekendDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E5E5), width: 1)),
              weekendTextStyle:
                  const TextStyle(fontSize: 14, color: Color(0xFF333333)),
              weekendSubTextStyle:
                  TextStyle(fontSize: 8, color: Color(0xFF33333366))),
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
        ),
      ),
    );
  }
}
