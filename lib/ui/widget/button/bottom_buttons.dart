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
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/statistics.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/toggle_icon_button.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';

class BottomButtons extends StatefulWidget {
  final Statistics node;
  final double left;
  final double gap;
  final Color color;
  final List<int> hides;

  BottomButtons(this.node, {this.left = 0, this.gap = 40, color, this.hides})
      : this.color = color ?? AppTheme.colors.support;

  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  List<bool> isClickeds; // likes, replies, bookmarks

  @override
  void initState() {
    super.initState();
    setState(() {
      this.isClickeds = [
        widget.node.isLiked(Session.user),
        false,
        widget.node.isBookmarked(Session.user)
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return PadongFutureBuilder(
        future: widget.node.getStatisticsWithoutMe(Session.user),
        builder: (bottoms) {
          if (widget.hides != null)
            for (int idx in widget.hides) bottoms[idx] = null;
          return Stack(children: [
            SizedBox(width: 500, height: 30),
            ...[0, 1, 2]
                .map((idx) => bottoms[idx] == null
                    ? null
                    : Positioned(
                        left: widget.left + widget.gap * this.getGapIdx(idx),
                        bottom: 2,
                        child: ToggleIconButton(
                          unclickeds[idx],
                          toggleIcon: clickeds[idx],
                          size: 16,
                          defaultColor: AppTheme.colors.support,
                          toggleColor: clickedClrs[idx],
                          isToggled: this.isClickeds[idx],
                          alignment: Alignment.bottomCenter,
                          onPressed: () {
                            if (idx == 0)
                              widget.node.updateLiked(Session.user);
                            else if (idx == 2)
                              widget.node.updateBookmarked(Session.user);
                            setState(() {
                              this.isClickeds[idx] = !this.isClickeds[idx];
                            });
                          },
                        )))
                .where((element) => element != null),
            ...[0, 1, 2]
                .map((idx) => bottoms[idx] == null
                    ? null
                    : Positioned(
                        left:
                            widget.left + 20 + widget.gap * this.getGapIdx(idx),
                        bottom: 1,
                        child: getNumText(idx, bottoms)))
                .where((element) => element != null)
          ]);
        });
  }

  Text getNumText(idx, bottoms) {
    return Text((bottoms[idx] + (this.isClickeds[idx] ? 1 : 0)).toString(),
        style: TextStyle(
            color: widget.color, fontSize: AppTheme.fontSizes.regular));
  }

  int getGapIdx(idx) {
    return widget.hides != null ? idx >> 1 : idx;
  }
}

List<IconData> unclickeds = [
  Icons.favorite_border_rounded,
  Icons.mode_comment_outlined,
  Icons.bookmark_border_rounded
];
List<IconData> clickeds = [
  Icons.favorite_rounded,
  Icons.mode_comment,
  Icons.bookmark_rounded
];
List<Color> clickedClrs = [
  AppTheme.colors.pointRed,
  AppTheme.colors.primary,
  AppTheme.colors.pointYellow
];
