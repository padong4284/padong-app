///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///*
///* Github [https://github.com/padong4284]
///*********************************************************************
import 'package:flutter/material.dart';
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/card/time_table.dart';
import 'package:padong/ui/widget/card/timeline_card.dart';
import 'package:padong/ui/widget/container/tab_container.dart';
import 'package:padong/ui/widget/container/timeline.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/board_list.dart';
import 'package:padong/util/time_manager.dart';

class ScheduleView extends StatelessWidget {
  final Schedule schedule;

  ScheduleView(this.schedule);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) => PadongButton(
            onPressAdd: () => PadongRouter.routeURL(
                'update?id=${this.schedule.id}&type=schedule', this.schedule),
            isScrollingDown: isScrollingDown,
            noShadow: true),
        title: 'Schedule',
        children: [
          SizedBox(height: 10),
          Stack(children: [
            this.eventsButton(),
            TabContainer(tabWidth: 70.0, tabs: [
              'Table',
              'Lecture'
            ], children: [
              TimeTable(this.schedule),
              PadongFutureBuilder(
                  future: this.schedule.getMyLectures(Session.user),
                  builder: (lectures) => BoardList(lectures, isLecture: true))
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
              onPressed: () => PadongRouter.routeURL(
                  '/rail?id=${this.schedule.id}&type=schedule', this.schedule)))
    ]);
  }

  Widget todayTimeline() {
    return PadongFutureBuilder(
        future: this.schedule.getMyEvents(Session.user),
        builder: (events) {
          Map<String, List<Widget>> timeline = {};
          for (Event event in events)
            for (TimeManager tm in event.times)
              if (tm.isToday())
                timeline[tm.time] =
                    (timeline[tm.time] ?? []) + [TimelineCard(event)];
          return Timeline(
              emptyMessage: 'Have a Nice Day :)',
              date: TimeManager.todayString(),
              timeline: timeline);
        });
  }
}
