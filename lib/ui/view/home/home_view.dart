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
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/core/node/map/building.dart';
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/question.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/top_app_bar.dart';
import 'package:padong/ui/widget/button/more_button.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/card/building_card.dart';
import 'package:padong/ui/widget/card/image_card.dart';
import 'package:padong/ui/widget/card/question_card.dart';
import 'package:padong/ui/widget/card/timeline_card.dart';
import 'package:padong/ui/widget/card/university_card.dart';
import 'package:padong/ui/widget/component/top_boards.dart';
import 'package:padong/ui/widget/component/univ_door.dart';
import 'package:padong/ui/widget/container/horizontal_scroller.dart';
import 'package:padong/ui/widget/container/more_expandable.dart';
import 'package:padong/ui/widget/container/swipe_deck.dart';
import 'package:padong/ui/widget/container/timeline.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/board_list.dart';
import 'package:padong/util/time_manager.dart';

class HomeView extends StatelessWidget {
  final University university;

  HomeView(this.university);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: TopAppBar('PADONG'),
      floatingActionButtonGenerator: (isScrollingDown) =>
          PadongButton(isScrollingDown: isScrollingDown),
      children: [
        UnivDoor(this.university),
        SizedBox(height: 35),
        TopBoards(this.university),
        ...(this.university.id == 'PADONG'
            ? this.univArea()
            : this.aboutArea()),
        ...this.questionArea(),
        ...this.eventsArea(),
        ...this.placesArea(),
        ...this.padongArea(context),
      ],
    );
  }

  List<Widget> aboutArea() {
    return [
      this._title('About Our University'),
      SizedBox(height: 10),
      PadongFutureBuilder(
          future: this.university.getChildren(Wiki()),
          builder: (wikis) => Column(
                children: <Widget>[...wikis.map((wiki) => ImageCard(wiki))],
              ))
    ];
  }

  List<Widget> univArea() {
    return [
      SizedBox(height: 10),
      PadongFutureBuilder(
          future: this.university.getChildren(University()),
          builder: (univs) => MoreExpandable(
                title: this._title('Universities'),
                children: <Widget>[
                  ...univs.map((univ) => UniversityCard(univ))
                ],
                folded: 5,
              ))
    ];
  }

  List<Widget> questionArea() {
    return [
      this._title('Questions'),
      SizedBox(height: 10),
      PadongFutureBuilder(
          future: this.university.getChildren(Board()),
          builder: (boards) {
            Board qBoard =
                boards.where((board) => board.title == 'Questions').first;
            return Column(children: [
              PadongFutureBuilder(
                future: (() async =>
                    (await qBoard.getChildren(Post())) +
                    (await qBoard.getChildren(Question())))(),
                builder: (_questions) {
                  return SwipeDeck(
                      emptyMessage: 'Ask any questions for Free!',
                      children: List.generate(min(5, _questions.length as int),
                          (idx) => QuestionCard(_questions[idx])));
                },
              ),
              MoreButton('/board?id=${qBoard.id}')
            ]);
          })
    ];
  }

  List<Widget> eventsArea() {
    return [
      this._title('Events in ${TimeManager.thisMonth()}'),
      PadongFutureBuilder(
          future: this.university.getChildren(Event()),
          builder: (events) {
            return Timeline(
                expandable: true,
                timeline: TimeManager.cutDayByDay(<Event>[...events]).map(
                    (date, events) => MapEntry(date,
                        events.map((event) => TimelineCard(event)).toList())),
                hideTopDate: true);
          })
    ];
  }

  List<Widget> placesArea() {
    return [
      this._title('Places'),
      PadongFutureBuilder(
          future: this.university.mappa.getChildren(Building()),
          builder: (buildings) => HorizontalScroller(
                emptyMessage:
                    'You can explore\nthe ${this.university.title}\non the Map and pin the place!',
                height: 150,
                children: [
                  ...List.generate(min(10, buildings.length as int),
                      (idx) => BuildingCard(buildings[idx]))
                ],
              ))
    ];
  }

  List<Widget> padongArea(BuildContext context) {
    return [
      this._title('PADONG'),
      PadongFutureBuilder(
          future: University.getPadongBoards(),
          builder: (boards) => BoardList(<Board>[...boards])),
      InkWell(
          onTap: () => this.showAboutPadong(context),
          child: Container(
              padding: const EdgeInsets.only(top: 30),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                this.logoPADONG(size: 30.0),
                Text('Contact Us',
                    style: AppTheme.getFont(
                        isBold: true,
                        color: AppTheme.colors.primary,
                        fontSize: AppTheme.fontSizes.large))
              ]))),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 5, bottom: 50),
          child: Text('Copyright 2021. PADONG. All rights reserved.',
              style: AppTheme.getFont(
                  color: AppTheme.colors.semiSupport,
                  fontSize: AppTheme.fontSizes.small))),
    ];
  }

  Widget _title(String title) {
    return Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 5),
        child: Text(title,
            style: AppTheme.getFont(
                fontSize: AppTheme.fontSizes.mlarge, isBold: true)));
  }

  void showAboutPadong(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationVersion: '1.0.0',
      applicationIcon: this.logoPADONG(),
      applicationLegalese: 'padong4284@gmail.com\nCopyright 2021, PADONG, All Rights Reserved',
    );
  }

  Widget logoPADONG({double size = 50}) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/logo/PADONG.png'),
          fit: BoxFit.fill,
        )));
  }
}
