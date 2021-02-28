const WEEKDAYS = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class TimeManager {
  DateTime thisMon;
  DateTime dateTime;
  Duration duration;
  List<String> dr;
  List<int> startT;

  int dMin;
  int get day => this.dateTime.day;
  int get hour => this.dateTime.hour;
  int get minute => this.dateTime.minute;
  int get weekday => this.dateTime.weekday;

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

  void setThisMonday() {
    DateTime now = DateTime.now();
    this.thisMon = DateTime(now.year, now.month, now.day - (now.weekday - 1));
  }
}
