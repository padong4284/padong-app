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
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/shared/notification.dart';

// parent: Deck
class Board extends TitleNode with Notification {
  String rule; // rule of this board, showing at Write page

  Board();

  Board.fromMap(String id, Map snapshot)
      : this.rule = snapshot['rule'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Board.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rule': this.rule,
    };
  }

  List<TitleNode> getNotices() {
    // TODO: get notice posts!
    // only owner can write, set isNotice
    return [];
  }
}
