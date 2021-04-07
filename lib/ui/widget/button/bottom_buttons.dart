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
import 'package:padong/core/node/deck/re_reply.dart';
import 'package:padong/core/node/deck/reply.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/node/mixin/statistics.dart';
import 'package:padong/ui/shared/button_properties.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/toggle_icon_button.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';

class BottomButtons extends StatefulWidget {
  final Statistics node;
  final double left;
  final double gap;
  final Color color;
  final List<int> hides;
  static Function(int idx) update;

  BottomButtons(this.node, {this.left = 0, this.gap = 40, color, this.hides})
      : this.color = color ?? AppTheme.colors.support;

  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  bool isReply;
  List<int> bottoms;
  List<bool> isClickeds = [false, false, false]; // likes, replies, bookmarks

  @override
  void initState() {
    super.initState();
    widget.node
        .getStatisticsWithoutMe(Session.user)
        .then((bottoms) => setState(() => this.bottoms = bottoms));
    this.isReply = widget.node is Reply || widget.node is ReReply;
    if (!this.isReply)
      BottomButtons.update = (int idx) {
        if (mounted)
          setState(() => this.isClickeds[idx] = !this.isClickeds[idx]);
      };
    this.isClickeds = [
      widget.node.isLiked(Session.user),
      false,
      widget.node.isBookmarked(Session.user)
    ];
    widget.node.isReplied(Session.user).then((isReplied) {
      if (mounted) setState(() => this.isClickeds[1] = isReplied);
    });
  }

  @override
  void dispose() {
    BottomButtons.update = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this.bottoms == null)
      return Center(
          child: Container(
        width: 15,
        height: 15,
        margin: const EdgeInsets.only(top: 10),
        child: CircularProgressIndicator(),
      ));
    if (widget.hides != null)
      for (int idx in widget.hides) this.bottoms[idx] = null;
    return Stack(children: [
      SizedBox(width: 500, height: 30),
      ...[0, 1, 2]
          .map((idx) => this.bottoms[idx] == null
              ? null
              : Positioned(
                  left: widget.left + widget.gap * this.getGapIdx(idx),
                  bottom: 2,
                  child: ToggleIconButton(
                    UnClickIcons[idx],
                    toggleIcon: ClickIcons[idx],
                    size: 16,
                    initEveryTime: true,
                    defaultColor: AppTheme.colors.support,
                    toggleColor: ClickColors[idx],
                    disabled: idx == 1,
                    isToggled: this.isClickeds[idx],
                    alignment: Alignment.bottomCenter,
                    onPressed: () {
                      if (idx == 0) {
                        widget.node.updateLiked(Session.user);
                        if (!this.isReply &&
                            BackAppBar.updateLikeBookmark != null)
                          BackAppBar.updateLikeBookmark(0);
                      } else if (idx == 2) {
                        widget.node.updateBookmarked(Session.user);
                        if (!this.isReply &&
                            BackAppBar.updateLikeBookmark != null)
                          BackAppBar.updateLikeBookmark(1);
                      }
                      if (mounted)
                        setState(() {
                          this.isClickeds[idx] = !this.isClickeds[idx];
                        });
                    },
                  )))
          .where((element) => element != null),
      ...[0, 1, 2]
          .map((idx) => this.bottoms[idx] == null
              ? null
              : Positioned(
                  left: widget.left + 20 + widget.gap * this.getGapIdx(idx),
                  bottom: 1,
                  child: getNumText(idx, this.bottoms)))
          .where((element) => element != null)
    ]);
  }

  Text getNumText(int idx, List<int> bottoms) {
    return Text(
        (bottoms[idx] + (idx != 1 && this.isClickeds[idx] ? 1 : 0)).toString(),
        style: TextStyle(
            color: widget.color, fontSize: AppTheme.fontSizes.regular));
  }

  int getGapIdx(idx) => widget.hides != null ? (idx + 1) >> 1 : idx;
}
