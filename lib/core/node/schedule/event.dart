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
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/shared/constants.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/utils/time_manager.dart';

// parent: Schedule, User
class Event extends Board {
  @override
  String rule = MEMO_RULE;
  PERIODICITY periodicity;
  List<TimeManager> times;
  List<String> alerts;

  Event();

  Event.fromMap(String id, Map snapshot)
      : this.periodicity = parsePERIODICITY(snapshot['periodicity']),
        this.times = <TimeManager>[
          ...snapshot['times'].map((time) => TimeManager.fromString(time))
        ],
        this.alerts = <String>[...snapshot['alerts']],
        super.fromMap(id, {...snapshot, 'rule': MEMO_RULE});

  @override
  generateFromMap(String id, Map snapshot) => Event.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rule': MEMO_RULE,
      'periodicity': periodicityToString(this.periodicity),
      'times': <String>[...this.times.map((tManager) => tManager.toString())],
      'alerts': this.alerts,
    };
  }
}
