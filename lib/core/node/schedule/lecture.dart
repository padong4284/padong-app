import 'package:padong/core/node/chat/chat_room.dart';
import 'package:padong/core/node/node.dart';

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
import 'package:padong/core/node/schedule/review.dart';
import 'package:padong/core/service/session.dart';
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
  Evaluation _evaluation;
  ChatRoom _chatRoom;

  Lecture();

  Lecture.fromMap(String id, Map snapshot)
      : this.professor = snapshot['professor'],
        this.room = snapshot['room'],
        this.grade = snapshot['grade'],
        this.exam = snapshot['exam'],
        this.attendance = snapshot['attendance'],
        this.book = snapshot['book'],
        super.fromMap(id, {
          ...snapshot,
          'rule': ASK_RULE,
          'periodicity': periodicityToString(PERIODICITY.WEEKLY)
        });

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

  Future<Evaluation> get evaluation async {
    if (this._evaluation == null)
      this._evaluation = (await this.getChild(Evaluation())) ??
          (await Evaluation.fromMap('', {
            'pip': 'Internal',
            'parentId': this.id,
            'ownerId': this.id,
            'title': this.title,
            'description': this.description,
            'rate': 0.0,
            'anonymity': true,
            'isNotice': false,
          }).create());
    return this._evaluation;
  }

  Future<List<Review>> getReviews() async {
    return <Review>[
      ...(await (await this.evaluation).getChildren(Review(), upToDate: true))
    ];
  }

  @override
  void setDataWithMap(Map data) {
    super.setDataWithMap(data);
    this.periodicity = data['periodicity'] ?? this.periodicity;
    this.professor = data['professor'] ?? this.professor;
    this.room = data['room'] ?? this.room;
    this.grade = data['grade'] ?? this.grade;
    this.exam = data['exam'] ?? this.exam;
    this.attendance = data['attendance'] ?? this.attendance;
    this.book = data['book'] ?? this.book;
  }

  @override
  Future<Node> create() async {
    // create ChatRoom
    Lecture _this = await super.create() as Lecture;
    this._chatRoom = await ChatRoom.fromMap('', {
      'pip': pipToString(PIP.INTERNAL),
      'parentId': _this.id,
      'ownerId': Session.currUniversity.id,
      'title': _this.title,
      'description': this.description,
    }).create();
    return _this;
  }

  Future<ChatRoom> getChatRoom() async {
    if (this._chatRoom == null)
      this._chatRoom = await this.getChild(ChatRoom());
    return this._chatRoom;
  }
}
