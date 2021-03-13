<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
=======
import 'package:padong/core/node/schedule/event.dart';
>>>>>>> feat: Event in this Moth with timeline

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
const WEEKDAYS = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class TimeManager {
  String source;
  DateTime thisMon;
  DateTime startTime;
  Duration duration;

  DateTime get endTime => this.startTime.add(this.duration);
  List<String> dr;
  List<int> startT;

  int dMin;

  int get year => this.startTime.year;

  int get month => this.startTime.month;

  int get day => this.startTime.day;

  int get hour => this.startTime.hour;

  int get minute => this.startTime.minute;

  int get weekday => this.startTime.weekday;

  String get date => formatDate(this.startTime);

  String get time => '${formatHM(this.hour)}:${formatHM(this.minute)}';

  String get range => this.dr[1];

  static TimeManager fromString(String time) {
    if (num.tryParse(time.split(' | ')[0][0]) != null)
      return TimeManager.dateNRange(time); // start with number
    return TimeManager.dayNRange(time);
  }

  TimeManager.dayNRange(String dayTimeRange) {
    /// WD | HH:MM ~ HH:MM
    try {
      this.init(dayTimeRange);
      assert(WEEKDAYS.indexOf(this.dr[0]) > 0);
      this.startTime = DateTime(
          this.thisMon.year,
          this.thisMon.month,
          this.thisMon.day + (WEEKDAYS.indexOf(this.dr[0]) - 1),
          this.startT[0],
          this.startT[1]);
      this.duration = Duration(hours: this.dMin ~/ 60, minutes: this.dMin % 60);
    } catch (e) {
      print(e);
      print(
          'TimeManager: Day And Range Wrong Format\nWEEKDAY | HH:MM ~ HH:MM\n$dayTimeRange');
    }
  }

  TimeManager.dateNRange(String dateTimeRange) {
    /// MM/DD/YYYY | HH:MM ~ HH:MM
    try {
      this.init(dateTimeRange);
      String source = this.dr[0].replaceAll('-', '/');
      List<int> date = source.split('/').map((d) => int.parse(d)).toList();
      this.startTime =
          DateTime(date[2], date[0], date[1], this.startT[0], this.startT[1]);
      this.duration = Duration(hours: this.dMin ~/ 60, minutes: this.dMin % 60);
    } catch (e) {
      print(e);
      print(
          'TimeManager: Date And Range Wrong Format\nMM/DD/YYYY | HH:MM ~ HH:MM\n$dateTimeRange');
    }
  }

  void init(String source) {
    this.source = source;
    this.setThisMonday();
    this.dr = source.split(' | ');
    List<String> startEnd = this.dr[1].split(' ~ ');
    this.startT = parseTime(startEnd[0]);
    List<int> endT = parseTime(startEnd[1]);
    this.dMin = (endT[0] - this.startT[0]) * 60 + endT[1] - this.startT[1];
  }

  String toString() => this.source;

  void setThisMonday() {
    DateTime now = DateTime.now();
    this.thisMon = DateTime(now.year, now.month, now.day - (now.weekday - 1));
  }

  bool isToday() {
    DateTime now = DateTime.now();
    return (now.year == this.year) &&
        (now.month == this.month) &&
        (now.day == this.day);
  }

  static String formatDate(DateTime dt) {
    return '${formatHM(dt.month)}/${formatHM(dt.day)}/${dt.year}';
  }

  static String formatTime(int hour, int minute) {
    return '${formatHM(hour)}:${formatHM(minute)}';
  }

  static List<int> parseTime(timeStr) {
    List temp = timeStr.split(':').map((t) => int.parse(t)).toList();
    return <int>[temp[0], temp[1]];
  }

  static String todayString() {
    return formatDate(DateTime.now());
  }

  static String todayWeekday() {
    DateTime now = DateTime.now();
    return ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][now.weekday];
  }

  static String formatHM(int hm) {
    String numStr = hm.toString();
    if (numStr.length != 2) numStr = '0' + numStr;
    return numStr;
  }

  static List<List<String>> summaryTimes(List<String> times, bool showWeekday) {
    /// 1st, time range equality
    /// 2nd, date equality
    Map<String, List> ranges = {};
    List<TimeManager> tms =
        times.map((t) => TimeManager.fromString(t)).toList();
    for (TimeManager tm in tms) {
      ranges[tm.range] = (ranges[tm.range] ?? []) +
          [showWeekday ? WEEKDAYS[tm.weekday] : tm.date.substring(0, 5)];
    }
    List<List<String>> summary = [];
    for (String range in ranges.keys) {
      String temp = ranges[range].toString();
      summary.add([range, temp.substring(1, temp.length - 1)]);
    }
    return summary;
  }

  //toDateTime convert various type of time to DateTime.
  //for supporting backward of firestore DateTime Data.
  static DateTime toDateTime(dynamic date){
    if (date is String){
      return DateTime.tryParse(date) ?? null;
    } else if(date is int) {
      return DateTime.fromMillisecondsSinceEpoch(date * 1000);
    } else if(date is FieldValue){
      return DateTime.now();
    } else if (date is Timestamp){
      return date.toDate();
    } else {
      return null;
    }
  }

  static bool isSameYMDHM(DateTime one, DateTime another) {
    return (one.minute == another.minute) &&
        (one.hour == another.hour) &&
        (one.day == another.day) &&
        (one.month == another.month) &&
        (one.year == another.year);
  }

  static Map<String, List<Event>> cutDayByDay(List<Event> events) {
    Map<String, List<Event>> cutDay = {};
    for (Event event in events)
      for (TimeManager tm in event.times)
        cutDay[tm.date] = (cutDay[tm.date] ?? []) + [event];
    return cutDay;
  }

  static String thisMonth() => monthString(DateTime.now().month);

  static String monthString(int m) {
    return [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ][m];
  }
}
