const WEEKDAYS = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class TimeManager {
  String weekday;
  DateTime dateTime;
  Duration duration;
  List<String> dr;
  List<int> startT;
  List<int> endT;
  int dMin;

  TimeManager.dayNRange(String dayTimeRange) {
    /// WD | HH:MM ~ HH:MM
    try {
      this.init(dayTimeRange);
      assert(WEEKDAYS.indexOf(this.dr[0]) > 0);
      this.weekday = this.dr[0];
      this.dateTime = DateTime(2000, 1, 1, this.startT[0], this.startT[1]);
      this.duration = Duration(hours: this.dMin ~/ 60, minutes: this.dMin % 60);
    } catch (e) {
      print(
          'TimeManager: Day And Range Wrong Format\nWEEKDAY | HH:MM ~ HH:MM\nWEEKDAY: $WEEKDAYS');
    }
  }

  TimeManager.dateNRange(String dateTimeRange) {
    /// MM/DD/YYYY | HH:MM ~ HH:MM
    try {
      this.init(dateTimeRange);
      List<int> date = this.dr[0].split('/').map((d) => int.parse(d)).toList();
      this.dateTime =
          DateTime(date[2], date[0], date[1], this.startT[0], this.startT[1]);
      this.weekday = WEEKDAYS[this.dateTime.weekday];
      this.duration = Duration(hours: this.dMin ~/ 60, minutes: this.dMin % 60);
    } catch (e) {
      print(
          'TimeManager: Date And Range Wrong Format\nMM/DD/YYYY | HH:MM ~ HH:MM');
    }
  }

  static List<int> parseTime(timeStr) =>
      timeStr.split(':').map((t) => int.parse(t)).toList();

  void init(String dateTimeRange) {
    this.dr = dateTimeRange.split(' | ');
    List<String> startEnd = this.dr[1].split(' ~ ');
    this.startT = parseTime(startEnd[0]);
    this.endT = parseTime(startEnd[1]);
    this.dMin =
        (this.endT[0] - this.startT[0]) * 60 + this.endT[1] - this.startT[1];
  }

  String getDate() {
    return _formatDateString(this.dateTime);
  }

  static String _formatDateString(DateTime dt) {
    return '${dt.month}/${dt.day}/${dt.year}';
  }

  static String todayString() {
    return _formatDateString(DateTime.now());
  }

  static String todayWeekday() {
    DateTime now = DateTime.now();
    return ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][now.weekday];
  }
}
