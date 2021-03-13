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
import 'package:padong/core/node/deck/reply.dart';

// parent: Reply, Argue, Review
class ReReply extends Reply {
  String grandParentId;

  ReReply();

  ReReply.fromMap(String id, Map snapshot)
      :
        this.grandParentId= snapshot['grandParentId'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => ReReply.fromMap(id, snapshot);

  @override
  Future<List<int>> getStatisticsWithoutMe(User me) async {
    List<int> statistics = await super.getStatisticsWithoutMe(me);
    statistics[1] = null;
    return statistics;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'grandParentId': this.grandParentId,
    };
  }
}
