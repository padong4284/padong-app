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
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/ui/widget/card/photo_card.dart';
import 'package:padong/ui/widget/container/horizontal_scroller.dart';
import 'package:padong/ui/widget/container/tab_container.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';

class TopBoards extends StatelessWidget {
  /// University's boards: Popular Favorite, Informs
  final University univ;

  TopBoards(this.univ);

  @override
  Widget build(BuildContext context) {
    return PadongFutureBuilder(
        future: this.univ.getChildren(Board()),
        builder: (_boards) {
          Map<String, Board> tabs = {};
          for (String tab in ['Popular', 'Favorite', 'Informs']) {
            tabs[tab] = _boards.where((board) => board.title == tab).first;
          }
          return TabContainer(
              tabWidth: 80.0,
              tabs: tabs.keys.toList(),
              children: tabs.values
                  .map((board) => PadongFutureBuilder(
                      future: board.getChildren(Post(), upToDate: true),
                      builder: (_posts) => HorizontalScroller(
                              moreLink: '/board?id=${board.id}',
                              padding: 3.0,
                              children: <Widget>[
                                ..._posts
                                    .sublist(0, min(10, _posts.length as int))
                                    .map((post) => PhotoCard(post))
                              ])))
                  .toList());
        });
  }
}
