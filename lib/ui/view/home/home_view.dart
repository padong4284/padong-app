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
import 'package:padong/core/node/schedule/question.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/top_app_bar.dart';
import 'package:padong/ui/widget/button/more_button.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/card/image_card.dart';
import 'package:padong/ui/widget/card/question_card.dart';
import 'package:padong/ui/widget/component/top_boards.dart';
import 'package:padong/ui/widget/component/univ_door.dart';
import 'package:padong/ui/widget/container/swipe_deck.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';

import 'package:padong/core/test/init.dart';
import 'package:padong/ui/widget/button/button.dart';

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
        //Button('INIT', onTap: () async => await initUniv()),
        UnivDoor(this.university),
        SizedBox(height: 35),
        TopBoards(this.university),
        ...this.aboutArea(),
        ...this.questionArea(),
      ],
    );
  }

  List<Widget> aboutArea() {
    return [
      this._title('About Georgia Tech'), // TODO: from currentUniv
      SizedBox(height: 10),
      PadongFutureBuilder(
          future: this.university.getChildren(Wiki()),
          builder: (wikis) => Column(
                children: <Widget>[...wikis.map((wiki) => ImageCard(wiki))],
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
                boards.where((board) => board.title == 'Question').first;
            return Column(children: [
              PadongFutureBuilder(
                future: qBoard.getChildren(Question()),
                builder: (_questions) {
                  return SwipeDeck(
                      emptyMessage: 'Ask Free!',
                      children: List.generate(min(5, _questions.length as int),
                          (idx) => QuestionCard(_questions[idx])));
                },
              ),
              MoreButton('/board?id=${qBoard.id}')
            ]);
          })
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
