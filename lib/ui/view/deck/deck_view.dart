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
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/deck/deck.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/component/top_boards.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/board_list.dart';

const PIPBS = ['Global', 'Public', 'Internal'];

class DeckView extends StatelessWidget {
  final Deck deck;

  DeckView(this.deck);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongButton(
          onPressAdd: Session.inMyUniv
              ? () => PadongRouter.routeURL('make?id=${this.deck.id}')
              : null,
          isScrollingDown: isScrollingDown),
      title: 'Deck',
      children: [
        SizedBox(height: 10),
        TopBoards(Session.currUniversity),
        SizedBox(height: 30),
        PadongFutureBuilder(
            future: this.deck.getChildren(Board()),
            builder: (boards) {
              Map<String, Board> pips = {};
              List<Board> others = [];
              for (Board board in boards) {
                if (PIPBS.contains(board.title))
                  pips[board.title] = board;
                else
                  others.add(board);
              }
              return Column(children: [
                BoardList([pips[PIPBS[0]], pips[PIPBS[1]], pips[PIPBS[2]]],
                    icons: [Icons.cloud, Icons.public, Icons.badge]),
                BoardList(others)
              ]);
            }),
        SizedBox(height: 10),
      ],
    );
  }
}
