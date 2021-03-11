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

class TabContainer extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> children;
  final double tabWidth;

  TabContainer({@required tabs, @required children, tabWidth})
      : assert(tabs.length == children.length),
        this.tabs = tabs,
        this.children = children,
        this.tabWidth = tabWidth ?? 70.0;

  @override
  _TabContainerState createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  int curIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                  widget.tabs.length,
                  (idx) => InkWell(
                      onTap: () {
                        setState(() {
                          this.curIdx = idx;
                        });
                      },
                      child: Container(
                          height: 25,
                          width: widget.tabWidth,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(widget.tabs[idx],
                              style: AppTheme.getFont(
                                isBold: this.curIdx == idx,
                                color: AppTheme.colors.fontPalette[1],
                                fontSize: AppTheme.fontSizes.mlarge,
                              )))))),
          Container(
              child: AnimatedPadding(
            padding: EdgeInsets.only(
                top: 2, left: this.curIdx * widget.tabWidth, bottom: 15),
            duration: Duration(milliseconds: 200),
            child: Container(
                width: widget.tabWidth - 5,
                height: 2,
                color: AppTheme.colors.support),
          )),
          widget.children[this.curIdx],
        ]));
  }
}
