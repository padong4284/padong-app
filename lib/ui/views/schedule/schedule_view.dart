import 'package:flutter/material.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/widgets/cards/time_table.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/containers/vertical_timeline.dart';
import 'package:padong/ui/widgets/cards/timelines/timeline_card.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';
import 'package:padong/core/apis/session.dart' as Session;

class ScheduleView extends StatelessWidget {
  final String id;
  final List<Map> todayEvents;
  final Map<String, dynamic> schedule;

  ScheduleView()
      : this.id = Session.user['scheduleId'],
        this.todayEvents = getTodayEvents(Session.user['scheduleId']),
        this.schedule = getScheduleAPI(Session.user['scheduleId']);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) =>
            PadongFloatingButton(
                onPressAdd: () {
                  PadongRouter.routeURL('update/id=${this.id}');
                },
                isScrollingDown: isScrollingDown),
        title: 'Schedule',
        children: [
          SizedBox(height: 10),
          Stack(children: [
            this.eventsButton(),
            TabContainer(tabWidth: 70.0, tabs: [
              'Table',
              'Lecture'
            ], children: [
              TimeTable(lectureIds: this.schedule['lectureIds']),
              BoardListTile(
                  boardIds: this.schedule['lectureIds'], isLecture: true)
            ])
          ]),
          SizedBox(height: 40),
          this.todayTimeline()
        ]);
  }

  Widget eventsButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox.shrink(),
      SizedBox(
          height: 25,
          child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(Icons.format_list_bulleted_rounded,
                  color: AppTheme.colors.support, size: 25),
              onPressed: () => PadongRouter.routeURL('/rail/id=${this.id}')))
    ]);
  }

  Widget todayTimeline() {
    List<String> dots = [];
    List<Map> events = [];
    for (Map event in this.todayEvents) {
      for (String time in event['times']) {
        TimeManager tm = TimeManager.fromString(time);
        if (tm.isToday()) {
          dots.add(tm.time);
          events.add(event);
        }
      }
    }
    return VerticalTimeline(
        date: TimeManager.todayString(),
        dots: dots,
        cards: [
          ...events.map((event) => [TimelineCard(event)])
        ]);
  }
}
