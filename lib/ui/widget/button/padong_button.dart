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
  final double radius = 80;
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
    if (widget.isSearchView) this.searchLevel = 1;
    double iconSize = 30.0;
    this.searchButtons.add(SizedBox(
        width: 56,
        child: FloatingActionButton(
            heroTag: null,
            elevation: widget.noShadow ? 0 : null,
            child:
                Icon(Icons.search, color: AppTheme.colors.base, size: iconSize),
            backgroundColor: AppTheme.colors.primary,
            onPressed: () {
              /*if (widget.isSearchView)
                setState(() => this.searchLevel = (this.searchLevel + 1) % 3);
              else
                PadongRouter.routeURL('/search');*/
              setState(() => this.searchLevel = (this.searchLevel + 1) % 3);
            })));

    this.searchButtons.add(Spinner(
        radius: 28 + this.radius,
        actions: [
          Icon(Icons.home, size: iconSize),
          Icon(Icons.wysiwyg, size: iconSize),
          Icon(Icons.book, size: iconSize)
        ],
        actionSize: iconSize,
        child: this.searchButtons[0]));

    this.searchButtons.add(Spinner(
        radius: 28 + this.radius * 2,
        actions: [
          Icon(Icons.home, size: iconSize),
          Icon(Icons.wysiwyg, size: iconSize),
          Icon(Icons.book, size: iconSize)
        ],
        actionSize: iconSize,
        child: this.searchButtons[1]));
  }
}
