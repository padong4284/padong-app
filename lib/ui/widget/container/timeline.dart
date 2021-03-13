import 'dart:math';

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
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/more_button.dart';
import 'package:padong/ui/widget/component/no_data_message.dart';
import 'package:padong/util/time_manager.dart';

class Timeline extends StatefulWidget {
  final String date; // TODO: DateTime class
  final Map<String, List<Widget>> timeline;
  final bool hideTopDate;
  final bool expandable;

  Timeline(
      {this.date,
      this.timeline,
      this.hideTopDate = false,
      this.expandable = false});

  _VerticalTimelineState createState() => _VerticalTimelineState();
}

class _VerticalTimelineState extends State<Timeline> {
  List<String> dots;
  List<List<Widget>> cards;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    this.dots = widget.timeline.keys.toList();
    this.cards = widget.timeline.values.toList();
    if (this.dots.length == 0) {
      this.dots = ['No Event'];
      this.cards = [
        [NoDataMessage("Let's plan something good!", height: 200)]
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    int len = min((widget.expandable && !this.expanded) ? 3 : this.dots.length,
        this.dots.length);
    return Stack(children: [
      Positioned.fill(
          top: widget.hideTopDate ? 15 : 35,
          left: 4,
          right: MediaQuery.of(context).size.width -
              2 * (AppTheme.horizontalPadding + 4),
          child: SizedBox(
              width: 2, child: Container(color: AppTheme.colors.lightSupport))),
      Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(children: [
            widget.hideTopDate ? SizedBox.shrink() : this.getTopDate(),
            ...List.generate(
                len,
                (idx) => Column(children: [
                      this.getDotTime(this.dots[idx]),
                      Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(children: this.cards[idx]))
                    ]))
          ])),
      widget.expandable && (this.dots.length > 3)
          ? Positioned(
              right: 0,
              child: MoreButton('',
                  expanded: this.expanded,
                  expandFunction: () => setState(() {
                        this.expanded = !this.expanded;
                      })))
          : SizedBox.shrink()
    ]);
  }

  Widget getTopDate() {
    bool isToday = TimeManager.todayString() == widget.date;
    return Row(children: [
      Text(
        isToday ? 'Today ' : widget.date,
        style: AppTheme.getFont(
            color: AppTheme.colors.support,
            fontSize: AppTheme.fontSizes.mlarge,
            isBold: true),
      ),
      isToday
          ? Text(widget.date,
              style: AppTheme.getFont(color: AppTheme.colors.semiSupport))
          : SizedBox.shrink()
    ]);
  }

  Widget getDotTime(String dotTime) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  width: 12, height: 12, color: AppTheme.colors.primary),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Text(dotTime,
                  style: AppTheme.getFont(color: AppTheme.colors.semiSupport)),
            )
          ],
        ));
  }
}
