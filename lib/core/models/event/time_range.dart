

/*
* TimeRange represent when the event starts and how long it lasts */
class TimeRange {

  DateTime startTime;
  Duration duration;

  TimeRange({
    this.startTime,
    this.duration});

  TimeRange.fromMap(Map snapshot,String id) :
      this.startTime = DateTime.parse(snapshot['startTime']?? ""),
      this.duration = Duration(seconds: snapshot['duration']) ?? Duration(seconds: 0);
  toJson() {
    return {
      'startTime': this.startTime.toIso8601String(),
      'duration': this.duration.inSeconds
    };
  }

}