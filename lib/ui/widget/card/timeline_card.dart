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
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/card/base_card.dart';
import 'package:padong/util/time_manager.dart';

class TimelineCard extends StatelessWidget {
  final bool isLecture;
  final Event event;
  final TimeManager timeManager;

  TimelineCard(this.event, {this.timeManager})
      : this.isLecture = (event.type == 'lecture');

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => PadongRouter.routeURL(
            '/event?id=${this.event.id}&type=${this.event.type}', this.event),
        child: BaseCard(children: [
          Text(this.isLecture ? 'Lecture' : 'Event',
              style: AppTheme.getFont(color: AppTheme.colors.fontPalette[3])),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(this.event.title,
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[1], isBold: true))),
          this.getTimeRange(),
        ]));
  }

  Text getTimeRange() => Text(this.getTerm(),
      style: AppTheme.getFont(color: AppTheme.colors.primary));

  String getTerm() {
    TimeManager tm = this.timeManager ?? this.event.times[0];
    return tm.range + (tm.dMin > 0 ? ' (${tm.dMin}min)' : ' All day');
  }
}
