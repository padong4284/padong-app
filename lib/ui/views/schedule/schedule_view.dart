import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/containers/vertical_timeline.dart';

class ScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      children: [
        VerticalTimeline(
            date: '04/02/2021',
            ids: Iterable<int>.generate(10)
                .map((idx) => idx.toString())
                .toList())
      ],
    );
  }
}
