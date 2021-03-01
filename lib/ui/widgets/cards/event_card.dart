import 'package:flutter/material.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

class EventCard extends StatelessWidget {
  final String id; // node's id
  final bool isLecture;
  final Map<String, dynamic> event;

  EventCard(id, {isLecture = false})
      : this.id = id,
        this.isLecture = isLecture,
        this.event = isLecture ? getLectureAPI(id) : getEventAPI(id);

  @override
  Widget build(BuildContext context) {
    return BaseCard(children: [
      this.timeRange(),
      Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 15),
          child: this.dateNYear()),
      ...this.infoList(['periodicity', 'alerts']),
    ]);
  }

  Widget timeRange() {
    List<List<String>> summaries =
        TimeManager.summaryTimes(this.event['times'], this.isLecture);
    return Column(
        children: summaries
            .map((summary) => Row(children: [
                  Text(summary[0],
                      style: AppTheme.getFont(
                          color: AppTheme.colors.primary, isBold: true)),
                  SizedBox(width: 5),
                  Text(summary[1],
                      style: AppTheme.getFont(color: AppTheme.colors.support))
                ]))
            .toList());
  }

  List<Row> infoList(List<String> infos) {
    List<Row> infoList = [];
    infos.forEach((info) => infoList.add(Row(children: [
          Text(info[0].toUpperCase() + info.substring(1),
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[2], isBold: true)),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                  this
                      .event[info]
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', ''),
                  style:
                      AppTheme.getFont(color: AppTheme.colors.fontPalette[2])))
        ])));
    return infoList;
  }

  Widget dateNYear() {
    TimeManager tm = TimeManager.fromString(this.event['times'][0]);
    return Row(children: [
      Text(tm.date.substring(0, 5),
          style: AppTheme.getFont(
              color: AppTheme.colors.fontPalette[1],
              fontSize: AppTheme.fontSizes.large,
              isBold: true)),
      Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(tm.year.toString(),
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[3],
                  fontSize: AppTheme.fontSizes.mlarge,
                  isBold: true)))
    ]);
  }
}
