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
import 'package:padong/ui/widget/bar/padong_navigation_bar.dart';
import 'package:padong/ui/view/home/home_view.dart';
/*
import 'package:padong/ui/view/cover/cover_view.dart';
import 'package:padong/ui/view/deck/deck_view.dart';
import 'package:padong/ui/view/map/map_view.dart';
import 'package:padong/ui/view/schedule/schedule_view.dart';
*/

final List<Widget> pages = [
  HomeView(Session.currUniversity),
];

class MainView extends StatefulWidget {
  // Session.registerUser is already complete.
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    // Register Context
    PadongRouter.registerContext(this.context);
    return Scaffold(
        bottomNavigationBar: PadongNavigationBar(
            selectedIdx: _selectedIdx,
            setSelectedIdx: (int idx) => setState(() {
              this._selectedIdx = 0; //idx; FIXME
            })),
        body: pages[this._selectedIdx]);
  }
}
