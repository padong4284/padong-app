import 'dart:math';
import 'package:flutter/material.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

double blockWidth;
const DAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
final List<Color> blockColors = [
  AppTheme.colors.semiPrimary,
  AppTheme.colors.primary,
  AppTheme.colors.semiSupport,
  AppTheme.colors.support,
  AppTheme.colors.fontPalette[3],
  AppTheme.colors.fontPalette[1],
  AppTheme.colors.fontPalette[0],
  AppTheme.colors.pointYellow,
];

class TimeTable extends StatefulWidget {
  final List lectures;

  // TODO: this week's events

  TimeTable({@required lectureIds})
      : this.lectures = lectureIds.map((id) => getLectureAPI(id)).toList();

  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  int startHour;
  int endHour;
  List lectureTimes = [];

  @override
  void initState() {
    super.initState();
    this.startHour = 9;
    this.endHour = 16;
    for (Map<String, dynamic> lecture in widget.lectures) {
      for (String time in lecture['times']) {
        TimeManager tm = TimeManager.fromString(time);
        this.lectureTimes.add([lecture['id'], lecture['title'], tm]);
        this.startHour = min(this.startHour, tm.hour);
        this.endHour = max(this.startHour, tm.hour + 1 + tm.dMin ~/ 60);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    blockWidth = (width - 2 * AppTheme.horizontalPadding - 35) / 5;

    return Stack(children: [
      BaseCard(padding: 0, width: 25 + blockWidth * 5, children: <Widget>[
        this.weekDays(),
        Container(height: 2, color: AppTheme.colors.fontPalette[3]),
        // horizontalLine
        ...this.hourLines(),
      ]),
      this.getVerticalLine(),
      ...this.lectureTimes.map((lectureTime) =>
          this.getBlock(lectureTime[0], lectureTime[1], lectureTime[2]))
    ]);
  }

  Widget getBlock(String lectureId, String title, TimeManager timeManager) {
    return Positioned(
        left: 31 + blockWidth * (timeManager.weekday - 1),
        top: 31 +
            42 * (timeManager.hour - this.startHour + timeManager.minute / 60),
        child: InkWell(
          onTap: () => PadongRouter.routeURL('/lecture/id=$lectureId'),
          child: SizedBox(
              width: blockWidth - 2,
              height: 42 * (timeManager.dMin / 60),
              child: Container(
                color: blockColors[title.length % blockColors.length],
                padding: const EdgeInsets.all(2),
                child: Text(title,
                    style: AppTheme.getFont(
                        color: AppTheme.colors.fontPalette[4])),
              )),
        ));
  }

  Widget weekDays() {
    List<Widget> days = [];
    for (String day in DAYS) {
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
