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
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/view/cover/cover_view.dart';
import 'package:padong/ui/view/deck/deck_view.dart';
import 'package:padong/ui/view/map/map_view.dart';
import 'package:padong/ui/view/schedule/schedule_view.dart';
import 'package:padong/ui/widget/bar/padong_navigation_bar.dart';
import 'package:padong/ui/view/home/home_view.dart';
import 'package:padong/ui/widget/button/padong_button.dart';

final List<Widget> pages = [
  HomeView(Session.currUniversity),
  CoverView(Session.currUniversity.cover),
  DeckView(Session.currUniversity.deck),
  ScheduleView(Session.currUniversity.schedule),
  MapView(Session.currUniversity.mappa),
];

class MainView extends StatefulWidget {
  // Session.registerUser is already complete.
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  int _selectedIdx = 0;
  bool isScrollingDown = false;
  static Function(bool) setMainScrollingDown;

  @override
  void initState() {
    super.initState();
    MainViewState.setMainScrollingDown =
        (bool isDown) => setState(() => this.isScrollingDown = true);
  }

  @override
  Widget build(BuildContext context) {
    // Register Context
    PadongRouter.registerContext(this.context);
    return Scaffold(
        floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
            child: PadongButton(isScrollingDown: this.isScrollingDown, noShadow: true)),
        bottomNavigationBar: PadongNavigationBar(
            selectedIdx: _selectedIdx,
            setSelectedIdx: (int idx) => setState(() {
                  this._selectedIdx = idx;
                })),
        body: pages[this._selectedIdx]);
  }
}
