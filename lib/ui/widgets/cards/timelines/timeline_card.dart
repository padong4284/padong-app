import 'package:flutter/material.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

class TimelineCard extends StatelessWidget {
  final String id; // node's id
  final bool isLecture;
  final Map<String, dynamic> event;

  TimelineCard(id, {this.isLecture = false})
      : this.event = getEventAPI(id),
        this.id = id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => PadongRouter.routeURL('/event/id=${this.id}'),
        child: BaseCard(children: [
          Text(this.isLecture ? 'Lecture' : 'Event',
              style: AppTheme.getFont(color: AppTheme.colors.fontPalette[3])),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(this.event['title'],
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[1], isBold: true))),
          this.getTimeRange(),
        ]));
  }

  Text getTimeRange() {
    return Text(this.getTerm(),
        style: AppTheme.getFont(color: AppTheme.colors.primary));
  }

  String getTerm() {
    String range = this.event['times'][0].split(' | ')[1];
    List<String> startEnd = range.split(' ~ ');
    List<int> startT = startEnd[0].split(':').map((t) => int.parse(t)).toList();
    List<int> endT = startEnd[1].split(':').map((t) => int.parse(t)).toList();
    return range +
        ' (${(endT[0] - startT[0]) * 60 + (endT[1] - startT[1])}min)'; // TODO: get Term from TimeRange
  }
}
