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
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/more_button.dart';
import 'package:padong/ui/widget/component/no_data_message.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/base_tile.dart';
import 'package:padong/ui/widget/tile/node/node_tile.dart';

class NoticeTile extends StatefulWidget {
  final Board board;

  NoticeTile(this.board);

  @override
  _NoticeTileState createState() => _NoticeTileState();
}

class _NoticeTileState extends State<NoticeTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return PadongFutureBuilder(
        future: widget.board.getNotices(),
        builder: (notices) => BaseTile(children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      this.noticeTitle(),
                      notices.length > 2
                          ? MoreButton('', expanded: this.expanded,
                              expandFunction: () {
                              setState(() {
                                this.expanded = !this.expanded;
                              });
                            })
                          : SizedBox.shrink()
                    ],
                  )),
              Container(height: 2, color: AppTheme.colors.support),
              ...List.generate(
                this.expanded ? notices.length : min(2, notices.length),
                (idx) => _NoticeTile(notices[idx],
                    (this.expanded ? notices.length : 2) == idx + 1),
              ),
              notices.length == 0 ? NoDataMessage('Nothing to Notice!', height: 100) : SizedBox.shrink()
            ]));
  }

  Widget noticeTitle() {
    return Row(children: [
      Padding(
          padding: const EdgeInsets.only(right: 5),
          child:
              Icon(Icons.campaign, color: AppTheme.colors.support, size: 25)),
      Text('Notice',
          style: AppTheme.getFont(
              color: AppTheme.colors.support,
              fontSize: AppTheme.fontSizes.mlarge,
              isBold: true))
    ]);
  }
}

class _NoticeTile extends NodeTile {
  final bool isLast;

  _NoticeTile(Post node, this.isLast) : super(node, noProfile: true);

  @override
  Widget bottomArea({List<int> hides, bool isSubNode}) {
    return SizedBox(height: 5);
  }

  @override
  Widget underLine() {
    return this.isLast
        ? SizedBox.shrink()
        : Container(
            height: 2,
            color: AppTheme.colors.lightSupport,
            margin: const EdgeInsets.only(top: 5));
  }
}
