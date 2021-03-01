const WEEKDAYS = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class TimeManager {
  DateTime thisMon;
  DateTime dateTime;
  Duration duration;
  List<String> dr;
  List<int> startT;

  int dMin;
  int get year => this.dateTime.year;
  int get month => this.dateTime.month;
  int get day => this.dateTime.day;
  int get hour => this.dateTime.hour;
  int get minute => this.dateTime.minute;
  int get weekday => this.dateTime.weekday;
  String get date => formatDate(this.dateTime);
  String get time => '${formatHM(this.hour)}:${formatHM(this.minute)}';
  String get range => this.dr[1];

  static TimeManager fromString(String time) {
    if (num.tryParse(time.split(' | ')[0][0]) != null)
      return TimeManager.dateNRange(time);
    return TimeManager.dayNRange(time);
  }

  TimeManager.dayNRange(String dayTimeRange) {
    /// WD | HH:MM ~ HH:MM
    try {
      this.init(dayTimeRange);
      assert(WEEKDAYS.indexOf(this.dr[0]) > 0);
      this.dateTime = DateTime(
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
      List<int> date = this.dr[0].split('/').map((d) => int.parse(d)).toList();
      this.dateTime =
          DateTime(date[2], date[0], date[1], this.startT[0], this.startT[1]);
      this.duration = Duration(hours: this.dMin ~/ 60, minutes: this.dMin % 60);
    } catch (e) {
      print(e);
      print(
          'TimeManager: Date And Range Wrong Format\nMM/DD/YYYY | HH:MM ~ HH:MM\n$dateTimeRange');
    }
  }

  static List<int> parseTime(timeStr) {
    List temp = timeStr.split(':').map((t) => int.parse(t)).toList();
    return <int>[temp[0], temp[1]];
  }

  void init(String dateTimeRange) {
    this.setThisMonday();
    this.dr = dateTimeRange.split(' | ');
    List<String> startEnd = this.dr[1].split(' ~ ');
    this.startT = parseTime(startEnd[0]);
    List<int> endT = parseTime(startEnd[1]);
    this.dMin = (endT[0] - this.startT[0]) * 60 + endT[1] - this.startT[1];
  }

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
    for(String range in ranges.keys) {
      String temp = ranges[range].toString();
      summary.add([range, temp.substring(1, temp.length-1)]);
    }
    return summary;
  }
}
