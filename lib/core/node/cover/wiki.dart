import 'package:padong/core/node/common/user.dart';

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
import 'package:padong/core/node/cover/argue.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/shared/statistics.dart';

// parent: Cover
class Wiki extends TitleNode with Statistics {
  String lastItemId;
  List<String> backLinks; // List of wikiId
  List<String> frontLinks; // List of wikiId

  Future<List<Argue>> get argues async {
    return await PadongFB.getDocsByRule('argue',
        rule: (query) => query
            .where('wikiId', isEqualTo: this.id)
            .orderBy("createdAt", descending: true)).then((docs) =>
        (docs ?? []).map((doc) => Argue.fromMap(doc.id, doc.data())).toList());
  }

  Wiki();

  Wiki.fromMap(String id, Map snapshot)
      : this.lastItemId = snapshot['lastItemId'],
        this.backLinks = <String>[...(snapshot['backLinks'] ?? [])],
        this.frontLinks = <String>[...(snapshot['frontLinks'] ?? [])],
        super.fromMap(id, snapshot) {
    this.likes = <String>[...(snapshot['likes'] ?? [])];
    this.bookmarks = <String>[...(snapshot['bookmarks'] ?? [])];
  }

  @override
  generateFromMap(String id, Map snapshot) => Wiki.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'lastItemId': this.lastItemId,
      'backLinks': this.backLinks ?? [],
      'frontLinks': this.frontLinks ?? [],
    };
  }

  void updateBackLinks(String targetWikiId, {bool isRemove = false}) async {
    // TODO: update firebase with Transaction, Target Wiki's frontLinks update
  }

  void updateFrontLinks(String targetWikiId, {bool isRemove = false}) async {
    // TODO: update firebase with Transaction, Target Wiki's backLinks update
  }

  @override
  Future<List<int>> getStatisticsWithoutMe(User me) async {
    return [
      // no count me
      (this.likes ?? []).where((id) => id != me.id).length,
      null,
      (this.bookmarks ?? []).where((id) => id != me.id).length,
    ];
  }

  Future<List<Wiki>> getLinks() async {
    List<String> links = this.backLinks + this.frontLinks;
    if (links.isEmpty) return [];
    return await PadongFB.getDocsByRule('wiki',
        rule: (query) => query
            .where('id', whereIn: links)
            .orderBy('createdAt', descending: true)).then(
        (docs) => docs.map((doc) => Wiki.fromMap(doc.id, doc.data())).toList());
  }
}
