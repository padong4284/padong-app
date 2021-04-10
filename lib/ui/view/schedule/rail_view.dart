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
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/card/timeline_card.dart';
import 'package:padong/ui/widget/container/timeline.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/util/time_manager.dart';

class RailView extends StatelessWidget {
  final Schedule schedule;

  // final Map<String, List> dayAndEvents;

  RailView(this.schedule);

  @override
  Widget build(BuildContext context) {
    return PadongFutureBuilder(
        future: this.schedule.getMyEvents(Session.user),
        builder: (events) {
          return SafePaddingTemplate(
              appBar: BackAppBar(title: 'Events', isClose: true),
              floatingActionButtonGenerator: (isScrollingDown) => PadongButton(
                  isScrollingDown: isScrollingDown, bottomPadding: 40),
              children: [
                Timeline(hideTopDate: true, timeline: this.cutDayByDay(events))
              ]);
        });
  }

  Map<String, List<Widget>> cutDayByDay(List<Event> events) {
    Map<String, List<Widget>> temp = {};
    Map<String, List<Widget>> timeline = {};
    for (Event event in events)
      for (TimeManager tm in event.times)
        temp[tm.date] =
            (temp[tm.date] ?? []) + [TimelineCard(event, timeManager: tm)];

    for (String date in temp.keys.toList()..sort()) timeline[date] = temp[date];
    return timeline;
  }
}
