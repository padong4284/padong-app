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
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/search_engine.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/top_app_bar.dart';
import 'package:padong/ui/widget/card/photo_card.dart';
import 'package:padong/ui/widget/container/horizontal_scroller.dart';
import 'package:padong/ui/widget/input/bottom_sender.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/util/padong/padong.dart';

class SearchView extends StatefulWidget {
  final Node currNode;
  final String level1;
  final String level2;
  final TextEditingController _searchController = TextEditingController();

  SearchView(this.currNode, this.level1, this.level2);

  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  bool isRendered = false;
  AnimationController _controller;
  Animation animation;
  bool startAnimate = true;
  Padong padong = Padong(
      100, List.generate(3, (_) => AppTheme.colors.primary.withAlpha(100)));
  String before = '';
  List<TitleNode> result = [];

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: TopAppBar('', withClose: true),
        floatingBottomBar: BottomSender(BottomSenderType.SEARCH,
            msgController: widget._searchController, onSubmit: () async {
          if (widget._searchController.text.isNotEmpty) {
            String type = {
                  'Univ.': 'university',
                  'Save': 'bookmark'
                }[widget.level2] ??
                widget.level2.toLowerCase();
            this.result = await SearchEngine.search(
                type, widget._searchController.text);
            setState(() {});
          }
          widget._searchController.text = '';
        }, onChange: (curr) {
          if (curr.isNotEmpty && curr.length != before.length)
            setState(() {
              this.padong.onKeyPressed(curr[curr.length - 1]);
            });
          before = curr;
        }),
        children: [
          this.level(),
          SizedBox(height: 30),
          HorizontalScroller(
              children: this.result.map((node) => PhotoCard(node)).toList())
        ],
        stackChildren: [
          this.keyboardWave()
        ]);
  }

  Widget level() {
    return Row(
        children: [widget.level1, '', widget.level2]
            .map((level) => level.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 15))
                : Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: AppTheme.colors.lightSupport,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(level)))
            .toList());
  }

  Widget keyboardWave() {
    return AnimatedContainer(
        transform:
            Matrix4.translationValues(0.0, this.isRendered ? 0.0 : 200, 0.0),
        duration: Duration(milliseconds: 400),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 210,
              child: CustomPaint(
                  painter: PadongPainter(this.padong), child: Container()),
            )));
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
    this.setRendered();
  }

  void setRendered() async {
    await Future.delayed(Duration(milliseconds: 250));
    if (this.mounted) setState(() => this.isRendered = true);
  }

  @override
  void dispose() {
    this._controller.dispose(); // finish animation
    super.dispose(); // due to lifecycle, call after controller disposed
  }

  void animate() async {
    await Future.delayed(Duration(milliseconds: 20));
    if (mounted) setState(() => this.padong.update());
    this.startAnimate = true;
  }
}
