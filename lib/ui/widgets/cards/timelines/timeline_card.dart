import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

class TimelineCard extends StatelessWidget {
  final bool isLecture;
  final Map<String, dynamic> event;

  TimelineCard(Map<String, dynamic> event)
      : this.event = event,
        this.isLecture = (event['professor'] != null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => PadongRouter.routeURL('/event?id=${this.event['id']}'),
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

  Text getTimeRange() => Text(this.getTerm(),
        style: AppTheme.getFont(color: AppTheme.colors.primary));

  String getTerm() {
    TimeManager tm = TimeManager.fromString(this.event['times'][0]);
    return tm.range + (tm.dMin > 0 ?' (${tm.dMin}min)' : ' All day'); // TODO: get Term from TimeRange
  }
}
