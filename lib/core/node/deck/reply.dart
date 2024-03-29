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
import 'package:padong/core/service/session.dart';
import 'package:padong/core/node/mixin/statistics.dart';
import 'package:padong/core/node/common/user.dart';

// parent: Post, Memo, Question
class Reply extends TitleNode with Statistics {
  @override
  String title = ''; // no Title
  bool anonymity; // hide profile

  Reply();

  Reply.fromMap(String id, Map snapshot)
      : this.anonymity = snapshot['anonymity'],
        super.fromMap(id, {...snapshot, 'title': ''}) {
    this.likes = <String>[...(snapshot['likes'] ?? [])];
    this.bookmarks = null; // reply can not bookmark
  }

  @override
  generateFromMap(String id, Map snapshot) => Reply.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'title': '',
      'anonymity': this.anonymity,
    };
  }

  @override
  Future<List<int>> getStatisticsWithoutMe(User me) async {
    List<int> statistics = await super.getStatisticsWithoutMe(Session.user);
    statistics[2] = null;
    return statistics;
  }
}
