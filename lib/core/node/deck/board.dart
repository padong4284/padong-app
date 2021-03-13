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
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/shared/notification.dart';

// parent: Deck
class Board extends TitleNode with Notification {
  String rule; // rule of this board, showing at Write page

  Board();

  Board.fromMap(String id, Map snapshot)
      : this.rule = snapshot['rule'],
        super.fromMap(id, snapshot) {
    this.subscribes = <String>[...snapshot['subscribes']];
  }

  @override
  generateFromMap(String id, Map snapshot) => Board.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rule': this.rule,
    };
  }

  Future<List<Post>> getNotices() async {
    Post temp = Post();
    return await PadongFB.getDocsByRule(temp.type,
            rule: (query) => query
                .where('parentId', isEqualTo: this.id)
                .where('isNotice', isEqualTo: true)
                .orderBy("createdAt", descending: true))
        .then((docs) => docs
            .map((doc) => temp.generateFromMap(doc.id, doc.data()) as Post)
            .toList())
        .catchError((e) => null);
  }
}
