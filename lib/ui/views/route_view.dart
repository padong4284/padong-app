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
import 'package:padong/ui/widgets/bars/padong_bottom_navigation_bar.dart';
import 'package:padong/ui/views/cover/cover_view.dart';
import 'package:padong/ui/views/deck/deck_view.dart';
import 'package:padong/ui/views/map/map_view.dart';
import 'package:padong/ui/views/schedule/schedule_view.dart';
import 'package:padong/ui/views/main/main_view.dart';

final List<Widget> pages = [
  MainView(),
  CoverView(),
  DeckView(),
  ScheduleView(),
  MapView(),
];

class RouteView extends StatefulWidget {
  @override
  _RouteViewState createState() => _RouteViewState();
}

class _RouteViewState extends State<RouteView> {
  int _selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    PadongRouter.registerContext(this.context);
    return Scaffold(
        bottomNavigationBar: PadongBottomNavigationBar(
            selectedIdx: _selectedIdx,
            setSelectedIdx: (int idx) => setState(() {
                  this._selectedIdx = idx;
                })),
        body: pages[this._selectedIdx]);
  }
}
