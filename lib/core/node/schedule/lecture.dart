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
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/shared/constants.dart';
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/evaluation.dart';

// parent: Schedule
class Lecture extends Event {
  @override
  String rule = ASK_RULE;
  @override
  PERIODICITY periodicity = PERIODICITY.WEEKLY;
  String professor;
  String room;
  String grade;
  String exam;
  String attendance;
  String book;

  Lecture();

  Lecture.fromMap(String id, Map snapshot)
      : this.professor = snapshot['professor'],
        this.room = snapshot['room'],
        this.grade = snapshot['grade'],
        this.exam = snapshot['exam'],
        this.attendance = snapshot['attendance'],
        this.book = snapshot['book'],
        super.fromMap(id,
            {...snapshot, 'rule': ASK_RULE, 'periodicity': PERIODICITY.WEEKLY});

  @override
  generateFromMap(String id, Map snapshot) => Lecture.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rule': ASK_RULE,
      'periodicity': periodicityToString(PERIODICITY.WEEKLY),
      'professor': this.professor,
      'room': this.room,
      'grade': this.grade,
      'exam': this.exam,
      'attendance': this.attendance,
      'book': this.book,
    };
  }

  Future<Evaluation> getEvaluation() async {
    return (await this.getChildren(Evaluation(), limit: 1))[0];
  }
}
