import 'package:flutter/material.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/cards/time_table.dart';
import 'package:padong/ui/widgets/containers/vertical_timeline.dart';
import 'package:padong/ui/widgets/cards/timelines/timeline_card.dart';
import 'package:padong/ui/widgets/cards/timelines/history_card.dart';

class ScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      children: [
        TimeTable('1234'),
        VerticalTimeline(date: '04/02/2021', dots: [
          '09:15',
          '10:30',
          '11:45'
        ], cards: [
          [TimelineCard('1')],
          [HistoryCard('2'), HistoryCard('3')],
          [TimelineCard('4'), TimelineCard('5'), TimelineCard('6')]
        ])
      ],
    );
  }
}
