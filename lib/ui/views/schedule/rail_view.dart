import 'package:flutter/material.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/cards/timelines/timeline_card.dart';
import 'package:padong/ui/widgets/containers/vertical_timeline.dart';

class RailView extends StatelessWidget {
  final String id;
  final Map<String, List<String>> dayAndIds;

  RailView(scheduleId)
      : this.id = scheduleId,
        this.dayAndIds = cutDayByDay(scheduleId);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(title: 'Events', isClose: true),
        children: [
      VerticalTimeline(
          hideTopDate: true,
          dots: this.dayAndIds.keys.toList(),
          cards: [
            ...this
                .dayAndIds
                .values
                .map((ids) => ids.map((id) => TimelineCard(id)).toList())
          ])
    ]);
  }

  static Map<String, List<String>> cutDayByDay(String scheduleId) {
    List items = getItemIdsAPI(scheduleId);
    Map<String, List<String>> cutDay = {};
    for (String itemId in items) {
      DateTime dt = getItemAPI(itemId)['createdAt'];
      String date = '${dt.month}/${dt.day}/${dt.year}';
      cutDay[date] = (cutDay[date] ?? []) + [itemId];
    }
    return cutDay;
  }
}
