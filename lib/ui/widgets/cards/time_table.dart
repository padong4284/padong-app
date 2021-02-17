import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

double blockWidth;

Map<String, String> getNode(String id) {
  return {'title': 'Title' + id, 'description': "It's sample description"};
}

class TimeTable extends StatelessWidget {
  // 1 hour Block's height: 42,
  // width: (MediaQuery.of(context).size.width - 2*AppTheme.horizontalPadding -27)/5
  final String _id; // node's _id
  final Map<String, String> node;

  TimeTable(id)
      : this.node = getNode(id),
        this._id = id;

  @override
  Widget build(BuildContext context) {
    int startHour = 9; // TODO: get start hour from data
    int endHour = 16;

    blockWidth = (MediaQuery.of(context).size.width -
            2 * AppTheme.horizontalPadding - 35) / 5;

    List<Widget> hourLines = [];
    for (int h = startHour; h < endHour; h++) {
      hourLines.add(getHourLine(h));
      hourLines.add(Container(height: 2, color: AppTheme.colors.lightSupport));
    }
    hourLines.add(getHourLine(endHour, isLast: true));

    return Stack(children: [
      BaseCard(padding: 0, width: 25 + blockWidth * 5, children: <Widget>[
        this.getWeekDays(),
        Container(height: 2, color: AppTheme.colors.semiSupport),
        ...hourLines,
      ]),
      this.getBlock(0, 9, 0, 60, startHour),
      this.getBlock(1, 10, 0, 60, startHour),
      this.getBlock(2, 11, 0, 60, startHour),
      this.getBlock(3, 12, 0, 60, startHour),
      this.getBlock(4, 13, 0, 60, startHour),
    ]);
  }

  Widget getBlock(
      int day, int hour, int minute, int durationMin, int startHour) {
    // day {Mon: 0, Tue: 1, Wed: 2, Thu: 3, Fri: 4}
    // duration: minute
    return Positioned(
        left: 30 + blockWidth * day,
        top: 31 + 42 * (hour - startHour + minute / 60),
        child: SizedBox(
            width: blockWidth,
            height: 42 * (durationMin / 60),
            child: Container(color: AppTheme.colors.pointYellow)));
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

  Widget getHourLine(int hour, {isLast = false}) {
    double height = isLast ? 20.0 : 40.0;
    List<Widget> hourLine = [];
    for (int _ = 0; _ < 5; _++) {
      hourLine.add(Container(
          width: 2, height: height, color: AppTheme.colors.lightSupport));
      hourLine
          .add(Container(width: blockWidth - 2, child: SizedBox(height: height)));
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
