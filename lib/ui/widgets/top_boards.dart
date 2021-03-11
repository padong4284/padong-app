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
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/cards/photo_card.dart';

class TopBoards extends StatelessWidget {
  final Map<String, dynamic> deck;
  final List<String> topBoards = ['Popular', 'Favorite', 'Inform'];

   TopBoards(deckId): this.deck = getDeckAPI(deckId);

  @override
  Widget build(BuildContext context) {
    return TabContainer(
            tabWidth: 80.0,
            tabs: this.topBoards,
            children: this.topBoards.map((boardName) {
              List<String> recent =
                  get10RecentPostIdsAPI(this.deck['fixedBoards'][boardName]);
              return HorizontalScroller(
                  moreId: this.deck['fixedBoards'][boardName],
                  padding: 3.0,
                  children: recent.map((postId) => PhotoCard(postId)).toList());
            }).toList());
  }
}
