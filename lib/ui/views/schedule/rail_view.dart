import 'package:flutter/material.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/widgets/cards/timelines/timeline_card.dart';
import 'package:padong/ui/widgets/containers/vertical_timeline.dart';

class RailView extends StatelessWidget {
  final String id;
  final Map<String, List> dayAndEvents;

  RailView(scheduleId)
      : this.id = scheduleId,
        this.dayAndEvents = cutDayByDay(scheduleId);

  @override
  Widget build(BuildContext context) {
    List<String> sorted = this.dayAndEvents.keys.toList();
    sorted.sort();
    return SafePaddingTemplate(
        appBar: BackAppBar(title: 'Events', isClose: true),
        floatingActionButtonGenerator: (isScrollingDown) =>
            PadongFloatingButton(isScrollingDown: isScrollingDown, bottomPadding: 40),
        children: [
          VerticalTimeline(hideTopDate: true, dots: sorted, cards: [
            ...sorted.map((date) => this
                .dayAndEvents[date]
                .map((event) => TimelineCard(event))
                .toList())
          ])
        ]);
  }

  static Map<String, List> cutDayByDay(String scheduleId) {
    List<String> ids = getEventIdsAPI(scheduleId);
    Map<String, List> cutDay = {};
    for (String id in ids) {
      Map event = getEventAPI(id);
      for (String time in event['times']) {
        TimeManager tm = TimeManager.fromString(time);
        cutDay[tm.date] = (cutDay[tm.date] ?? []) + [event];
      }
    } // TODO: periodicity
    return cutDay;
  }
}
