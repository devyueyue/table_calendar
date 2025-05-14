// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
          firstDay: _focusedDay.subtract(Duration(days: 31)),
          lastDay: _focusedDay.add(Duration(days: 31)),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          rowHeight: 76,
          // headerVisible: false,
          pageAnimationEnabled: false,
          availableGestures: AvailableGestures.none,
          pointCheckList: [1, 2, 3, 5, 6, 8, 9, 10],
          pointCount: '20',
          checkCycle: 6,
          calendarStyle: CalendarStyle(
            cellMargin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            defaultDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE5E5E5), width: 1)),
            defaultTextStyle: TextStyle(
                fontSize: 14, color: Color(0xFF333333).withOpacity(0.6)),
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
            weekendTextStyle: TextStyle(
                fontSize: 14, color: Color(0xFF333333).withOpacity(0.6)),
            weekendSubTextStyle:
                TextStyle(fontSize: 8, color: Color(0xFF33333366)),
            pointMissDecoration: BoxDecoration(
                color: Color(0xFFEBEBEB),
                borderRadius: BorderRadius.circular(10)),
            pointMissCycleDecoration: BoxDecoration(
                color: Color(0xFFEBEBEB),
                border: Border.all(color: const Color(0xFFB3B3B3), width: 1),
                borderRadius: BorderRadius.circular(10)),
            pointMissTextStyle: TextStyle(
                fontSize: 14, color: Color(0xFF333333).withOpacity(0.6)),
            pointMissSubTextStyle: TextStyle(
                fontSize: 8, color: Color(0xFF333333).withOpacity(0.6)),
          ),
          pointCheckIc: 'assets/images/point_check_ic.png',
          pointTodayIc: 'assets/images/point_today_ic.png',
          pointNotStartIc: 'assets/images/point_not_start_ic.png',
          pointMissIc: 'assets/images/point_miss_ic.png',
          pointCycleIc: 'assets/images/cycle_ic.png',
          pointMissCycleIc: 'assets/images/miss_cycle_ic.png',
          daysOfWeekHeight: 30,
          locale: 'id_ID',
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (selectedDay.day == _focusedDay.day) {
              return;
            }
            print(
                '-----hhy---点击了--day=${selectedDay.day}----fo=${focusedDay.day}');
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
