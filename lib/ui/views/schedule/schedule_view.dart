import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/containers/vertical_timeline.dart';
import 'package:padong/ui/widgets/cards/event_card.dart';

class ScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      children: [
        VerticalTimeline(
            indexs: Iterable<int>.generate(10)
                .map((idx) => idx.toString())
                .toList(),
            children:
                Iterable<int>.generate(10).map((idx) => EventCard('1234')).toList())
      ],
    );
  }
}
