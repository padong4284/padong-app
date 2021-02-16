import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/containers/vertical_timeline.dart';
import 'package:padong/ui/widgets/cards/time_card.dart';

class ScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      children: [
        VerticalTimeline(date: '04/02/2021', dots: [
          '09:15',
          '10:30',
          '11:45'
        ], cards: [
          [TimeCard('1')],
          [TimeCard('2'), TimeCard('3')],
          [TimeCard('4'), TimeCard('5'), TimeCard('6')]
        ])
      ],
    );
  }
}
