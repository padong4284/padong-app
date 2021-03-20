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
import 'package:padong/core/search_engine.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/widget/container/spinner.dart';

class PadongButton extends StatefulWidget {
  final Function onPressAdd;
  final bool isScrollingDown;
  final bool noShadow;
  final double bottomPadding;
  final IconData replaceAddIcon;
  final bool isSearchView;

  PadongButton(
      {this.onPressAdd,
      this.isScrollingDown = false,
      this.noShadow = false,
      this.bottomPadding = 0,
      this.replaceAddIcon,
      this.isSearchView = false});

  _PadongButtonState createState() => _PadongButtonState();
}

class _PadongButtonState extends State<PadongButton> {
  final double iconSize = 30.0;
  final double radius = 65;
  List<Widget> searchButtons = [];
  int searchLevel = 0;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Container(
            padding: EdgeInsets.only(
                right: 10.0, bottom: 10.0 + widget.bottomPadding),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              (widget.onPressAdd != null) && (this.searchLevel == 0)
                  ? AnimatedOpacity(
                      opacity: widget.isScrollingDown ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 300),
                      child: SizedBox(
                          width: 56,
                          child: FloatingActionButton(
                            heroTag: null,
                            child: Icon(widget.replaceAddIcon ?? Icons.add,
                                color: AppTheme.colors.base, size: 30),
                            backgroundColor: AppTheme.colors.support,
                            onPressed: widget.onPressAdd,
                          )))
                  : SizedBox.shrink(),
              SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                  opacity: (this.searchLevel == 0) && widget.isScrollingDown
                      ? 0.0
                      : 1.0,
                  duration: Duration(milliseconds: 600),
                  child: Container(
                      transform: Matrix4.translationValues(
                          this.radius * this.searchLevel,
                          this.radius * this.searchLevel,
                          0.0),
                      child: this.searchButtons[this.searchLevel]))
            ])));
  }

  @override
  void initState() {
    super.initState();
    this.initButtons();
  }

  void initButtons() {
    this.searchButtons = [null, null, null];
    this.searchButtons[0] = SizedBox(
        width: 56,
        child: FloatingActionButton(
            heroTag: null,
            elevation: widget.noShadow ? 0 : null,
            child: Icon(Icons.search,
                color: AppTheme.colors.base, size: this.iconSize),
            backgroundColor: AppTheme.colors.primary,
            onPressed: () {
              this.setLevel1();
              setState(() => this.searchLevel = (this.searchLevel + 1) % 2);
            }));
    this.setLevel1();
  }

  void setLevel1([String level1]) {
    Color color =
        level1 == null ? AppTheme.colors.base : AppTheme.colors.semiPrimary;
    Color getColor(label) => level1 != null
        ? (label == level1 ? AppTheme.colors.base : color)
        : color;
    this.searchButtons[1] = new Spinner(
        padding: 8,
        initAngle: 5.2,
        color: Color(0xFF20AADD),
        radius: 28 + this.radius,
        actions: SearchEngine.level1.keys
            .map((label) => InkWell(
                onTap: () => this.setLevel2(label),
                child: Column(children: [
                  Icon(SearchEngine.level1[label],
                      size: this.iconSize, color: getColor(label)),
                  Text(label,
                      style: AppTheme.getFont(
                          color: getColor(label),
                          fontSize: AppTheme.fontSizes.small))
                ])))
            .toList(),
        actionSize: this.iconSize + 20.0,
        child: Container(
            decoration: new BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 3,
              )
            ]),
            child: this.searchButtons[0]));
  }

  void setLevel2(String level1, [String level2]) {
    this.searchLevel = 2;
    this.setLevel1(level1);
    Map<String, IconData> _level2 = SearchEngine.level2[level1];
    Color getColor(label) =>
        label == level2 ? AppTheme.colors.base : AppTheme.colors.semiPrimary;
    this.searchButtons[2] = Spinner(
        color: Color(0xFF50B8DD),
        radius: 28.0 + 2 * this.radius,
        actions: _level2.keys
            .map((label) => InkWell(
                onTap: () {
                  this.setLevel2(level1, label);
                  PadongRouter.routeURL('/search?l1=$level1&l2=$label');
                },
                child: Column(children: [
                  Icon(_level2[label],
                      size: this.iconSize, color: getColor(label)),
                  Text(label,
                      style: AppTheme.getFont(
                          color: getColor(label),
                          fontSize: AppTheme.fontSizes.small))
                ])))
            .toList(),
        actionSize: this.iconSize + 20.0,
        child: this.searchButtons[1]);
    setState(() {});
  }
}
