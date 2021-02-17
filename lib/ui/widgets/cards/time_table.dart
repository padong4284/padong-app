import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

double blockWidth;
List<Color> blockColors = [
  AppTheme.colors.primary,
  AppTheme.colors.semiPrimary,
  AppTheme.colors.support,
  AppTheme.colors.semiSupport,
  AppTheme.colors.lightSupport,
  AppTheme.colors.pointYellow,
];
Color lineColor = AppTheme.colors.fontPalette[3];

class TimeTable extends StatelessWidget {
  // 1 hour Block's height: 42,
  // width: (MediaQuery.of(context).size.width - 2*AppTheme.horizontalPadding -27)/5
  final String _id; // node's _id
  final int startHour; // TODO: get start hour from node data
  final int endHour;

  TimeTable(id, {this.startHour = 9, this.endHour = 16}) : this._id = id;

  @override
  Widget build(BuildContext context) {
    blockWidth = (MediaQuery.of(context).size.width -
            2 * AppTheme.horizontalPadding -
            35) /
        5;

    List<Widget> hourLines = [];
    for (int h = this.startHour; h < this.endHour; h++) {
      hourLines.add(getHourLine(h));
      hourLines.add(Container(height: 2, color: AppTheme.colors.lightSupport));
    }
    hourLines.add(getHourLine(this.endHour, isLast: true));

    return Stack(children: [
      BaseCard(padding: 0, width: 25 + blockWidth * 5, children: <Widget>[
        this.getWeekDays(),
        Container(height: 2, color: lineColor), // horizontalLine
        ...hourLines,
      ]),
      this.getVerticalLine(),
      this.getBlock('Algorithm', 0, 9, 0, 120),
      this.getBlock('Data Structure', 1, 10, 0, 100),
      this.getBlock('System Programming', 2, 11, 0, 80),
      this.getBlock('Interview', 3, 12, 0, 60),
      this.getBlock('Title', 4, 13, 0, 40),
    ]);
  }

  Widget getBlock(
    String title,
    int day,
    int hour,
    int minute,
    int durationMin,
  ) {
    // day {Mon: 0, Tue: 1, Wed: 2, Thu: 3, Fri: 4}
    // duration: minute
    return Positioned(
        left: 31 + blockWidth * day,
        top: 31 + 42 * (hour - this.startHour + minute / 60),
        child: InkWell(
            onTap: () {
              // TODO: routing Lecture
            },
            child: SizedBox(
                width: blockWidth - 2,
                height: 42 * (durationMin / 60),
                child: Container(
                  color: blockColors[title.length % 6], // TODO: random color
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    title,
                    style: AppTheme.getFont(
                        color: AppTheme.colors.fontPalette[4],
                        fontSize: AppTheme.fontSizes.small),
                  ),
                ))));
  }

  Widget getWeekDays() {
    List<Widget> days = [];
    for (String day in ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']) {
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
                  fontSize: AppTheme.fontSizes.regular))));
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
            color: lineColor));
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
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[3],
                  fontSize: AppTheme.fontSizes.regular))),
      ...hourLine
    ]);
  }
}
