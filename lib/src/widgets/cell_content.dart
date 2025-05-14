// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/src/customization/calendar_builders.dart';
import 'package:table_calendar/src/customization/calendar_style.dart';

class CellContent extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;
  final bool isTodayHighlighted;
  final bool isToday;
  final bool isSelected;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isWithinRange;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;
  final String currentMonth;
  final CalendarStyle calendarStyle;
  final CalendarBuilders calendarBuilders;
  final String pointCount;
  final String pointCycleCount;
  final bool isCheckCycle;
  //已签到
  final bool pointIsCheck;
  //遗漏签到
  final bool pointMissCheck;
  final String pointCheckIc;
  final String pointMissIc;
  final String pointMissCycleIc;
  final String pointCheckCycleIc;
  final String pointFutureCycleIc;
  final String pointNotStartIc;
  final String pointTodayIc;

  const CellContent({
    super.key,
    required this.day,
    required this.focusedDay,
    required this.calendarStyle,
    required this.calendarBuilders,
    required this.isTodayHighlighted,
    required this.isToday,
    required this.isSelected,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.isWithinRange,
    required this.isOutside,
    required this.isDisabled,
    required this.isHoliday,
    required this.isWeekend,
    required this.currentMonth,
    required this.pointCount,
    required this.pointCycleCount,
    required this.pointIsCheck,
    required this.pointMissCheck,
    required this.pointCheckIc,
    required this.pointMissIc,
    required this.pointMissCycleIc,
    required this.pointCheckCycleIc,
    required this.pointFutureCycleIc,
    required this.pointNotStartIc,
    required this.pointTodayIc,
    required this.isCheckCycle,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final dowLabel = DateFormat.EEEE(locale).format(day);
    final dayLabel = DateFormat.yMMMMd(locale).format(day);
    final semanticsLabel = '$dowLabel, $dayLabel';

    Widget? cell =
        calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);

    if (cell != null) {
      return Semantics(
        label: semanticsLabel,
        excludeSemantics: true,
        child: cell,
      );
    }

    final text =
        calendarStyle.dayTextFormatter?.call(day, locale) ?? '${day.day}';
    final margin = calendarStyle.cellMargin;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;
    const duration = Duration(milliseconds: 250);

    if (isDisabled) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.disabledDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.disabledTextStyle),
          );
    } else if (isRangeStart) {
      cell =
          calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                padding: padding,
                decoration: calendarStyle.rangeStartDecoration,
                alignment: alignment,
                child: Text(text, style: calendarStyle.rangeStartTextStyle),
              );
    } else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.rangeEndDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.rangeEndTextStyle),
          );
    } else if (isToday && isTodayHighlighted) {
      cell = calendarBuilders.todayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: (isCheckCycle && pointIsCheck)
                ? BoxDecoration(
                    color: const Color(0xFFF2FFF3),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xFF26A6BA), width: 1))
                : isCheckCycle
                    ? calendarStyle.weekendDecoration
                    : calendarStyle.todayDecoration,
            alignment: alignment,
            child: (isCheckCycle && pointIsCheck)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 1),
                        child: Image.asset(
                          pointCheckCycleIc,
                          width: double.infinity,
                          height: 28,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF26A6BA),
                              borderRadius: BorderRadius.circular(9)),
                          child: Column(
                            children: [
                              Text('+${pointCycleCount}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              Text('${text} ${currentMonth}',
                                  style: const TextStyle(
                                      fontSize: 7, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : isCheckCycle
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 1),
                            child: Image.asset(
                              pointFutureCycleIc,
                              width: double.infinity,
                              height: 28,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color(0xFFFEA832),
                                  borderRadius: BorderRadius.circular(9)),
                              child: Column(
                                children: [
                                  Text('+${pointCycleCount}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                  Text('${text} ${currentMonth}',
                                      style: const TextStyle(
                                          fontSize: 7, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(pointTodayIc, width: 12),
                          Text('+${pointCount}',
                              style: calendarStyle.todayTextStyle),
                          Text('${text} ${currentMonth}',
                              style: calendarStyle.todaySubTextStyle),
                        ],
                      ),
          );
    } else if (isHoliday) {
      cell = calendarBuilders.holidayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.holidayDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.holidayTextStyle),
          );
    } else if (isWithinRange) {
      cell =
          calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                padding: padding,
                decoration: calendarStyle.withinRangeDecoration,
                alignment: alignment,
                child: Text(text, style: calendarStyle.withinRangeTextStyle),
              );
    } else if (isOutside) {
      cell = calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
          SizedBox.shrink();
    } else if (pointMissCheck) {
      cell = calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: isCheckCycle
                ? calendarStyle.pointMissCycleDecoration
                : calendarStyle.pointMissDecoration,
            alignment: alignment,
            child: isCheckCycle
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Image.asset(pointMissCycleIc, width: 30),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFFCCCCCC),
                              borderRadius: BorderRadius.circular(9)),
                          child: Column(
                            children: [
                              Text('+${pointCycleCount}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Color(0xFF333333).withOpacity(0.6))),
                              Text('${text} ${currentMonth}',
                                  style: TextStyle(
                                      fontSize: 7,
                                      color:
                                          Color(0xFF333333).withOpacity(0.6))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(pointMissIc, width: 12),
                      Text('+${pointCount}',
                          style: calendarStyle.pointMissTextStyle),
                      Text('${text} ${currentMonth}',
                          style: calendarStyle.pointMissSubTextStyle),
                    ],
                  ),
          );
    } else if (pointIsCheck) {
      cell = calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: isCheckCycle
                ? BoxDecoration(
                    color: const Color(0xFFF2FFF3),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xFF26A6BA), width: 1))
                : calendarStyle.selectedDecoration,
            alignment: alignment,
            child: isCheckCycle
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 1),
                        child: Image.asset(
                          pointCheckCycleIc,
                          width: double.infinity,
                          height: 28,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF26A6BA),
                              borderRadius: BorderRadius.circular(9)),
                          child: Column(
                            children: [
                              Text('+${pointCycleCount}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              Text('${text} ${currentMonth}',
                                  style: const TextStyle(
                                      fontSize: 7, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(pointCheckIc, width: 12),
                      Text('+${pointCount}',
                          style: calendarStyle.selectedTextStyle),
                      Text('${text} ${currentMonth}',
                          style: calendarStyle.selectedSubTextStyle),
                    ],
                  ),
          );
    } else {
      cell = calendarBuilders.defaultBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: isCheckCycle
                ? calendarStyle.weekendDecoration
                : calendarStyle.defaultDecoration,
            alignment: alignment,
            child: isCheckCycle
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 1),
                        child: Image.asset(
                          pointFutureCycleIc,
                          width: double.infinity,
                          height: 28,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFFFEA832),
                              borderRadius: BorderRadius.circular(9)),
                          child: Column(
                            children: [
                              Text('+${pointCycleCount}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              Text('${text} ${currentMonth}',
                                  style: const TextStyle(
                                      fontSize: 7, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(pointNotStartIc, width: 12),
                      Text('+${pointCount}',
                          style: isWeekend
                              ? calendarStyle.weekendTextStyle
                              : calendarStyle.defaultTextStyle),
                      Text(
                        '${text} ${currentMonth}',
                        style: isWeekend
                            ? calendarStyle.weekendSubTextStyle
                            : calendarStyle.defaultSubTextStyle,
                      ),
                    ],
                  ),
          );
    }

    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: cell,
    );
  }
}
