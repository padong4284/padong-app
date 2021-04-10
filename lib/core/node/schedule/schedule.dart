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
import 'package:padong/core/node/node.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/lecture.dart';
import 'package:padong/core/service/padong_fb.dart';

// parent: University
class Schedule extends Node {
  Schedule();

  Schedule.fromMap(String id, Map snapshot) : super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Schedule.fromMap(id, snapshot);

  Future<List<Lecture>> getMyLectures(User me) async {
    if (me.lectureIds.isEmpty) return [];
    return await PadongFB.getDocsByRule('lecture',
            rule: (query) => query.where('parentId', isEqualTo: this.id),
            whereIn: {PadongFB.documentId: me.lectureIds})
        .then((docs) => <Lecture>[
              ...docs.map((doc) => Lecture.fromMap(doc.id, doc.data()))
            ]);
  }

  Future<List<Event>> getMyEvents(User me) async {
    // TODO: get Public, Internal Events from Schedule also
    return <Event>[...(await me.getChildren(Event(), upToDate: true))];
  }
}
