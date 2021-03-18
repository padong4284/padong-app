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
import 'package:padong/core/node/node.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/top_app_bar.dart';
import 'package:padong/ui/widget/input/bottom_sender.dart';
import 'package:padong/util/padong/padong.dart';

class SearchView extends StatefulWidget {
  final Node currNode;
  final TextEditingController _searchController = TextEditingController();

  SearchView(this.currNode);

  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  bool startAnimate = true;
  Padong padong = Padong(
      100, List.generate(3, (_) => AppTheme.colors.primary.withAlpha(100)));
  String before = '';

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: TopAppBar('', withClose: true),
        floatingBottomBar: BottomSender(BottomSenderType.SEARCH,
            msgController: widget._searchController, onSubmit: () {
          if (widget._searchController.text.isNotEmpty) {}
          widget._searchController.text = '';
        }, onChange: (curr) {
          if (curr.length > before.length)
            setState(() {
              this.padong.onKeyPressed(curr[curr.length - 1]);
            });
          before = curr;
        }),
        children: [],
        stackChildren: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 210,
                  child: CustomPaint(
                    painter: PadongPainter(this.padong),
                    child: Container(),
                  )))
        ]);
  }

  @override
  void initState() {
    super.initState();
    this._controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    this.animation = CurvedAnimation(
        parent: this._controller, // using controller, not this.controller
        curve: Curves.bounceInOut);
    this.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        this._controller.reverse();
      else if (status == AnimationStatus.dismissed) this._controller.forward();
    });

    this.animation.addListener(() {
      if (this.startAnimate) {
        this.startAnimate = false;
        this.animate();
      }
    });
    this._controller.forward();
  }

  @override
  void dispose() {
    this._controller.dispose(); // finish animation
    super.dispose(); // due to lifecycle, call after controller disposed
  }

  void animate() async {
    await Future.delayed(Duration(milliseconds: 20));
    if (mounted)
      setState(() {
        this.padong.update();
      });
    this.startAnimate = true;
  }
}
