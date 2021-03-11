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
import 'package:padong/core/apis/cover.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/cards/timelines/history_card.dart';
import 'package:padong/ui/widgets/containers/vertical_timeline.dart';

class HistoryView extends StatelessWidget {
  final String id;
  final Map<String, List<String>> dayAndIds;

  HistoryView(wikiId)
      : this.id = wikiId,
        this.dayAndIds = cutDayByDay(wikiId);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(children: [
      VerticalTimeline(
          hideTopDate: true,
          dots: this.dayAndIds.keys.toList(),
          cards: [
            ...this.dayAndIds.values.map(
                (ids) => ids.map((id) => HistoryCard(id, this.id)).toList())
          ])
    ]);
  }

  static Map<String, List<String>> cutDayByDay(String wikiId) {
    List items = getItemIdsAPI(wikiId);
    Map<String, List<String>> cutDay = {};
    for (String itemId in items) {
      DateTime dt = getItemAPI(itemId)['createdAt'];
      String date = '${dt.month}/${dt.day}/${dt.year}';
      cutDay[date] = (cutDay[date] ?? []) + [itemId];
    }
    return cutDay;
  }
}
