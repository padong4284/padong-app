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
import 'package:padong/core/node/cover/item.dart';
import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/widget/card/history_card.dart';
import 'package:padong/ui/widget/container/timeline.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';

class HistoryView extends StatelessWidget {
  final Wiki wiki;

  HistoryView(this.wiki);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(children: [
      PadongFutureBuilder(
          future: this.wiki.getChildren(Item()),
          builder: (items) {
            return Timeline(
                emptyMessage: 'No Editing History Yet!',
                hideTopDate: true,
                timeline: this.cutDayByDay(<Item>[...items]));
          })
    ]);
  }

  Map<String, List<Widget>> cutDayByDay(List<Item> items) {
    Map<String, List<Widget>> cutDay = {};
    for (Item item in items) {
      DateTime dt = item.createdAt;
      String date = '${dt.month}/${dt.day}/${dt.year}';
      cutDay[date] = (cutDay[date] ?? []) + [HistoryCard(item)];
    }
    return cutDay;
  }
}
