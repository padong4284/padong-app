import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

Map<String, dynamic> getEvent(String id) {
  return {
    'title': 'Birthday',
    'timeRange': '00:00 ~ 24:00',
    'date': '03/21/2021',
    'rate': 4.5,
    'infos': {
      'Periodicity': 'Annual',
      'Alerts': '00:00',
    }
  };
}

class TimelineCard extends StatelessWidget {
  final String id; // node's id
  final bool isLecture;
  final Map<String, dynamic> event;

  TimelineCard(id, {this.isLecture = false})
      : this.event = getEvent(id),
        this.id = id;

  @override
  Widget build(BuildContext context) {
    return BaseCard(children: [
      Text(this.isLecture ? 'Lecture' : 'Event',
          style: AppTheme.getFont(
              color: AppTheme.colors.fontPalette[3])),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(this.event['title'],
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[1],
                  isBold: true))),
      this.getTimeRange(),
    ]);
  }

  Text getTimeRange() {
    return Text(this.event['timeRange'] + this.getTerm(),
        style: AppTheme.getFont(
            color: AppTheme.colors.primary));
  }

  String getTerm() {
    return ' (90min)'; // TODO: get Term from TimeRange
  }
}
