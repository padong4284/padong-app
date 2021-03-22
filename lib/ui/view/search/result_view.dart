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
import 'package:padong/core/node/title_node.dart';
import 'package:padong/ui/widget/card/building_card.dart';
import 'package:padong/ui/widget/card/event_card.dart';
import 'package:padong/ui/widget/card/image_card.dart';
import 'package:padong/ui/widget/card/lecture_card.dart';
import 'package:padong/ui/widget/card/photo_card.dart';
import 'package:padong/ui/widget/card/service_card.dart';
import 'package:padong/ui/widget/card/university_card.dart';
import 'package:padong/ui/widget/component/no_data_message.dart';
import 'package:padong/ui/widget/container/horizontal_scroller.dart';
import 'package:padong/ui/widget/tile/board_list.dart';
import 'package:padong/ui/widget/tile/friend_tile.dart';
import 'package:padong/ui/widget/tile/node/chat_room_tile.dart';

class ResultView extends StatelessWidget {
  final List<TitleNode> result;
  final String emptyMessage;
  final Map<String, Function> cardGenerator = {
    'university': (_node) => UniversityCard(_node),
    'wiki': (_node) => ImageCard(_node),
    'event': (_node) => EventCard(_node, isRouting: true),
    'lecture': (_node) => LectureCard(_node, isRouting: true),
    'building': (_node) => BuildingCard(_node),
    'service': (_node) => ServiceCard(_node),
    'chatroom': (_node) => ChatRoomTile(_node),
    'user': (_node) => FriendTile(_node),
  };

  ResultView(this.result, bool isSearched)
      : this.emptyMessage =
            isSearched ? 'Nothing to Show you' : 'You can Search by Title';

  @override
  Widget build(BuildContext context) {
    if (this.result.isEmpty)
      return NoDataMessage(this.emptyMessage, height: 100);
    else if (this.result[0].type == 'board')
      return BoardList(<Board>[...this.result]);
    bool isColumn = this.cardGenerator.keys.contains(this.result[0].type);
    return isColumn
        ? Column(
            children: this.result.map((node) => this.getCard(node)).toList())
        : HorizontalScroller(
            children: this.result.map((node) => this.getCard(node)).toList());
  }

  Widget getCard(TitleNode node) {
    return (this.cardGenerator[node.type] ?? (_node) => PhotoCard(_node))(node);
  }
}
