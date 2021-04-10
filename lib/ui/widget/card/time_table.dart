///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///*
///* Github [https://github.com/padong4284]
///*********************************************************************
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/card/base_card.dart';
import 'package:padong/util/time_manager.dart';

double blockWidth;
const DAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
final List<Color> backColors = [
  AppTheme.colors.fontPalette[3],
  AppTheme.colors.support,
  AppTheme.colors.primary,
  AppTheme.colors.semiPrimary,
  AppTheme.colors.semiSupport,
  AppTheme.colors.pointYellow,
  AppTheme.colors.fontPalette[1],
  AppTheme.colors.fontPalette[0],
];

class TimeTable extends StatefulWidget {
  final Schedule schedule;
  final List<Event> thisWeekEvents;

  TimeTable(this.schedule, this.thisWeekEvents);

  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  int startHour = 9;
  int endHour = 16;
  List<List> lectureAndTMs = [];
  Map<String, Color> colorSet = {};

  @override
  void initState() {
    super.initState();
    this.startHour = 9;
    this.endHour = 16;
    widget.schedule.getMyLectures(Session.user).then((lectures) => setState(() {
          this._appendToSchedule(lectures);
        }));
  }

  void _appendToSchedule(List<Event> events) {
    for (Event lecture in events) {
      this.colorSet[lecture.id] =
          backColors[this.colorSet.length % backColors.length];
      for (TimeManager tm in lecture.times) {
        this.lectureAndTMs.add([lecture, tm]);
        this.startHour = min(this.startHour, tm.hour);
        this.endHour = max(this.endHour, tm.hour + 1 + tm.dMin ~/ 60);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    blockWidth = (width - 2 * AppTheme.horizontalPadding - 35) / 5;
    this._appendToSchedule(widget.thisWeekEvents);

    return Stack(children: [
      BaseCard(padding: 0, width: 25 + blockWidth * 5, children: <Widget>[
        this.weekDays(),
        Container(height: 2, color: AppTheme.colors.fontPalette[3]),
        // horizontalLine
        ...this.hourLines(),
      ]),
      this.getVerticalLine(),
      ...this
          .lectureAndTMs
          .map((lectureTime) => this.getBlock(lectureTime[0], lectureTime[1]))
    ]);
  }

  Widget getBlock(Event lecture, TimeManager tm) {
    if (tm.weekday > 5) return SizedBox.shrink();
    return Positioned(
        left: 31 + blockWidth * (tm.weekday - 1),
        top: 31 + 42 * (tm.hour - this.startHour + tm.minute / 60),
        child: InkWell(
          onTap: () =>
              PadongRouter.routeURL('/${lecture.type}?id=${lecture.id}', lecture),
          child: SizedBox(
              width: blockWidth - 2,
              height: 42 * (tm.dMin / 60),
              child: Container(
                color: this.colorSet[lecture.id],
                padding: const EdgeInsets.all(2),
                child: Text(lecture.title,
                    style: AppTheme.getFont(
                        fontSize: AppTheme.fontSizes.small,
                        color: AppTheme.colors.fontPalette[4])),
              )),
        ));
  }

  Widget weekDays() {
    List<Widget> days = [];
    for (String day in WEEKDAYS.sublist(1, 6)) {
      days.add(Container(
          width: 2,
          height: 25,
          margin: const EdgeInsets.only(right: 5),
          color: AppTheme.colors.lightSupport));
      days.add(Container(
          width: blockWidth - 7,
          child: Text(day,
              style: AppTheme.getFont(
                color: AppTheme.colors.fontPalette[1],
              ))));
    }
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [SizedBox(width: 25), ...days]);
  }

  Widget getVerticalLine() {
    return Positioned(
        top: 4,
        left: 29,
        child: Container(
            width: 2,
            height: 47.0 + 42 * (this.endHour - this.startHour),
            color: AppTheme.colors.fontPalette[3]));
  }

  List<Widget> hourLines() {
    List<Widget> lines = [];
    for (int h = this.startHour; h < this.endHour; h++) {
      lines.add(this.getHourLine(h));
      lines.add(Container(height: 2, color: AppTheme.colors.lightSupport));
    }
    lines.add(getHourLine(this.endHour, isLast: true));
    return lines;
  }

  Widget getHourLine(int hour, {isLast = false}) {
    double height = isLast ? 20.0 : 40.0;
    List<Widget> hourLine = [];
    for (int _ = 0; _ < 5; _++) {
      hourLine.add(Container(
          width: 2, height: height, color: AppTheme.colors.lightSupport));
      hourLine.add(
          Container(width: blockWidth - 2, child: SizedBox(height: height)));
    }
    return Row(children: [
      Container(
          alignment: Alignment.topRight,
          width: 25,
          height: height,
          child: Text(hour.toString(),
              style: AppTheme.getFont(color: AppTheme.colors.fontPalette[3]))),
      ...hourLine
    ]);
  }
}
