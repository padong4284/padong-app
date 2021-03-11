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
import 'package:padong/core/node/deck/reply.dart';

// parent: Item
class Argue extends Reply {
  @override // always profile!
  bool anonymity = false;
  bool isClosed;
  String wikiId;

  Argue();

  Argue.fromMap(String id, Map snapshot)
      : this.isClosed = snapshot['isClosed'],
        this.wikiId = snapshot['wikiId'],
        super.fromMap(id, {...snapshot, 'anonymity': false});

  @override
  generateFromMap(String id, Map snapshot) => Argue.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': false,
      'isClosed': this.isClosed,
      'wikiId': this.wikiId,
    };
  }
}
