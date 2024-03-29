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
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/more_button.dart';
import 'package:padong/ui/widget/component/no_data_message.dart';

class HorizontalScroller extends StatelessWidget {
  final List<Widget> children;
  final double padding;
  final double height;
  final String moreLink;
  final String emptyMessage;
  final parentLeftPadding;
  final parentRightPadding;

  HorizontalScroller(
      {@required this.children,
        this.height = 220,
        this.parentLeftPadding = AppTheme.horizontalPadding,
        this.parentRightPadding = AppTheme.horizontalPadding,
        this.moreLink,
        this.emptyMessage,
        padding})
      : this.padding = padding ?? 5;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int len = this.children.length;
    return Column(children: [
      Container(
          height: this.height,
          transform:
          Matrix4.translationValues(-this.parentLeftPadding, 0.0, 0.0),
          child: Container(
              transform:
              Matrix4.translationValues(this.parentRightPadding, 0.0, 0.0),
              child: this.children.length > 0
                  ? this.horizontalList(width, len)
                  : NoDataMessage(this.emptyMessage ??
                  "You've got a Chance\nto be the first writer!"))),
      this.moreLink != null ? MoreButton(this.moreLink) : SizedBox.shrink()
    ]);
  }

  Widget horizontalList(double width, int len) {
    return OverflowBox(
        minWidth: width,
        maxWidth: width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: this
              .children
              .map((elm) => Container(
              padding: (this.children.indexOf(elm) % max(1, len - 1) == 0)
                  ? EdgeInsets.only(
                left: this.children.indexOf(elm) == 0
                    ? this.parentLeftPadding - 5
                    : this.padding,
                right: this.children.indexOf(elm) == 0
                    ? this.padding
                    : this.parentRightPadding,
              )
                  : EdgeInsets.symmetric(horizontal: this.padding),
              child: elm))
              .toList(),
        ));
  }
}