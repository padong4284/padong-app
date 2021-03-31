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

class ScheduleView extends StatefulWidget {
  final Schedule schedule;

  ScheduleView(this.schedule);

  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  List<Event> thisWeekEvents;
  Map<String, List<Widget>> todayTimeline = {};

  @override
  void initState() {
    super.initState();
    this.loadSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) => PadongButton(
            onPressAdd: () {
              PadongRouter.refresh = this.loadSchedule;
              PadongRouter.routeURL(
                  'update?id=${widget.schedule.id}&type=schedule',
                  widget.schedule);
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
              TimeTable(widget.schedule, this.thisWeekEvents ?? []),
              PadongFutureBuilder(
                  future: widget.schedule.getMyLectures(Session.user),
                  builder: (lectures) => BoardList(lectures, isLecture: true))
            ])
          ]),
          SizedBox(height: 40),
          Timeline(
              emptyMessage: 'Have a Nice Day :)',
              date: TimeManager.todayString(),
              timeline: this.todayTimeline)
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
                  '/rail?id=${widget.schedule.id}&type=schedule',
                  widget.schedule)))
    ]);
  }

  void loadSchedule() {
    Map<String, List<Widget>> _timeline = {};
    widget.schedule.getMyEvents(Session.user).then((events) {
      this.thisWeekEvents = [];
      for (Event event in events)
        for (TimeManager tm in event.times) {
          if (tm.isToday())
            _timeline[tm.time] =
                (_timeline[tm.time] ?? []) + [TimelineCard(event)];
          if (tm.isThisWeek() && !this.thisWeekEvents.contains(event))
            this.thisWeekEvents.add(event);
        }
      List<String> dots = _timeline.keys.toList();
      dots.sort();
      for(String dot in dots) this.todayTimeline[dot] = _timeline[dot];
      setState(() {});
    });
  }
}
