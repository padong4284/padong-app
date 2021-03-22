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

class EventCard extends StatelessWidget {
  final bool isRouting;
  final bool isLecture;
  final Event event;

  EventCard(this.event, {this.isLecture = false, this.isRouting = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.isRouting
            ? () =>
                PadongRouter.routeURL('/event?id=${this.event.id}', this.event)
            : null,
        child: BaseCard(children: [
          this.isRouting ? this.title() : this.timeRange(),
          Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 15),
              child: this.title()),
          ...this.infoList(['periodicity', 'alerts']),
        ]));
  }

  Widget timeRange() {
    List<List<String>> summaries =
        TimeManager.summaryTimes(this.event.times, this.isLecture);
    return Column(
        children: summaries
            .map((summary) =>
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Text(summary[0],
                      style: AppTheme.getFont(
                          color: AppTheme.colors.primary, isBold: true)),
                  SizedBox(width: 5),
                  Text(summary[1],
                      style: AppTheme.getFont(
                          color: AppTheme.colors.support,
                          fontSize: AppTheme.fontSizes.small))
                ]))
            .toList());
  }

  List<Row> infoList(List<String> infos) {
    List<Row> infoList = [];
    Map<String, dynamic> eventInfos = this.event.toJson();
    infos.forEach((info) => infoList.add(Row(children: [
          Text(info[0].toUpperCase() + info.substring(1),
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[2], isBold: true)),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                  eventInfos[info]
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', ''),
                  style:
                      AppTheme.getFont(color: AppTheme.colors.fontPalette[2])))
        ])));
    return infoList;
  }

  Widget title() {
    return Row(children: [
      Text(this.event.title,
          style: AppTheme.getFont(
              color: AppTheme.colors.fontPalette[1],
              fontSize: AppTheme.fontSizes.large,
              isBold: true)),
    ]);
  }

  Widget dateNYear() {
    TimeManager tm = this.event.times[0];
    return Row(children: [
      Text(tm.date.substring(0, 5),
          style: AppTheme.getFont(
              color: AppTheme.colors.fontPalette[1],
              fontSize: AppTheme.fontSizes.large,
              isBold: true)),
      Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(tm.year.toString(),
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[3],
                  fontSize: AppTheme.fontSizes.mlarge,
                  isBold: true)))
    ]);
  }
}
