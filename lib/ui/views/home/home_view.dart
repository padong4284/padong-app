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
import 'package:padong/core/apis/init.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/widgets/bars/top_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/more_button.dart';
import 'package:padong/ui/widgets/cards/building_card.dart';
import 'package:padong/ui/widgets/cards/question_card.dart';
import 'package:padong/ui/widgets/cards/timelines/timeline_card.dart';
import 'package:padong/ui/widgets/cards/image_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/containers/swipe_deck.dart';
import 'package:padong/ui/widgets/containers/vertical_timeline.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';
import 'package:padong/ui/widgets/top_boards.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/univ_door.dart';

class HomeView extends StatelessWidget {
  final University univ;

  HomeView(this.univ);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: TopAppBar('PADONG'),
      floatingActionButtonGenerator: (isScrollingDown) =>
          PadongFloatingButton(isScrollingDown: isScrollingDown),
      children: [
        //Button(title: 'INIT', callback: () async => await initUniversity()),
        UnivDoor(),
        SizedBox(height: 35),
        TopBoards(this.univ),
        //...this.aboutArea(),
        //...this.questionArea(),
        //...this.eventsArea(),
        // ...this.placesArea(),
        ...this.padongArea(),
      ],
    );
  }

  List<Widget> aboutArea() {
    return [
      this._title('About Georgia Tech'), // TODO: from currentUniv
      SizedBox(height: 10),
      ...{
        // TODO: from university
        'Vision': 'w009000',
        'Mission': 'w009001',
        'History': 'w009002',
      }.values.map((wikiId) => ImageCard(wikiId)) // TODO: change wiki tile
    ];
  }

  List<Widget> questionArea() {
    return [
      this._title('Questions'),
      SizedBox(height: 10),
      SwipeDeck(children: List.generate(5, (i) => QuestionCard('$i'))),
      MoreButton('/board?id=${'questionsBoardId'}')
    ];
  }

  List<Widget> eventsArea() {
    // TODO: more button
    return [
      this._title('Events in ${TimeManager.thisMonth()}'),
      VerticalTimeline(
          expandable: true,
          dots: List.generate(5, (i) => '3/2$i'),
          cards: List.generate(5, (_) => [TimelineCard(getEventAPI('123'))]),
          hideTopDate: true)
    ];
  }

  List<Widget> placesArea() {
    return [
      this._title('Places'),
      HorizontalScroller(
          height: 150,
          children: [
            ...List.generate(10, (idx) => BuildingCard(Post())) //FIXME
          ],
          moreLink: '123')
    ];
  }

  List<Widget> padongArea() {
    return [
      this._title('PADONG'),
      BoardListTile(
          boardIds: ['freeTalk', 'questionAnswer', 'inform'],
          isAlertTile: true),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 30),
          child: Text('Contact Us')),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 20),
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
}
