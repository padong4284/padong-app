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
import 'package:flutter/rendering.dart';
import 'package:padong/ui/theme/app_theme.dart';

class SafePaddingTemplate extends StatefulWidget {
  final String title;
  final PreferredSizeWidget appBar;
  final Widget floatingActionButton;
  final Widget Function(bool)
      floatingActionButtonGenerator; // (isScrollingDown) => Widget
  final Widget floatingBottomBar;
  final Widget Function(bool)
      floatingBottomBarGenerator; // (isScrollingDown) => Widget
  final List<Widget> children;
  final bool isBottomBar;
  final Widget background;

  const SafePaddingTemplate(
      {this.appBar,
      floatingActionButton,
      floatingActionButtonGenerator,
      floatingBottomBar,
      floatingBottomBarGenerator,
      @required this.children,
      this.background,
      this.title = ''})
      : assert((floatingActionButton == null) ||
            (floatingActionButtonGenerator == null)),
        assert((floatingBottomBar == null) ||
            (floatingBottomBarGenerator == null)),
        this.floatingActionButton = floatingActionButton,
        this.floatingActionButtonGenerator = floatingActionButtonGenerator,
        this.floatingBottomBar = floatingBottomBar,
        this.floatingBottomBarGenerator = floatingBottomBarGenerator,
        this.isBottomBar =
            (floatingBottomBar != null) || (floatingBottomBarGenerator != null);

  @override
  _SafePaddingTemplateState createState() => new _SafePaddingTemplateState();
}

class _SafePaddingTemplateState extends State<SafePaddingTemplate> {
  bool isRendered = false;
  ScrollController _scrollController; // set controller on scrolling
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    this._scrollController = new ScrollController();
    this._scrollController.addListener(() {
      setState(() {
        isScrollingDown =
            (this._scrollController.position.userScrollDirection ==
                ScrollDirection.reverse);
      });
    });
    this.isRendered = false;
    this.setRendered();
  }

  void setRendered() async {
    await Future.delayed(Duration(milliseconds: 250));
    if (this.mounted)
      setState(() {
        this.isRendered = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appBar,
        floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
            child: widget.floatingActionButton ??
                (widget.floatingActionButtonGenerator != null
                    ? widget.floatingActionButtonGenerator(this.isScrollingDown)
                    : SizedBox.shrink())),
        body: Stack(children: [
          widget.background ?? SizedBox.shrink(),
          SafeArea(
              child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null)
                FocusManager.instance.primaryFocus.unfocus();
            },
            child: Stack(children: [
              SingleChildScrollView(
                controller: this._scrollController,
                padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.horizontalPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.title.length > 0 ? this._topTitle() : null,
                      ...widget.children,
                      widget.isBottomBar ? SizedBox(height: 30) : null
                    ].where((elm) => elm != null).toList()),
              ),
              AnimatedContainer(
                  transform: Matrix4.translationValues(
                      0.0, this.isRendered ? 0.0 : 200, 0.0),
                  duration: Duration(milliseconds: 400),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: widget.floatingBottomBar ??
                          (widget.floatingBottomBarGenerator != null
                              ? widget.floatingBottomBarGenerator(
                                  this.isScrollingDown)
                              : SizedBox.shrink())))
            ]),
          ))
        ]));
  }

  Widget _topTitle() {
    return Container(
        height: AppBar().preferredSize.height,
        alignment: Alignment.centerLeft,
        child: Text(widget.title,
            style: AppTheme.getFont(
                fontSize: AppTheme.fontSizes.large,
                color: AppTheme.colors.semiPrimary)));
  }

  @override
  void dispose() {
    this._scrollController.removeListener(() {});
    this._scrollController.dispose();
    super.dispose();
  }
}