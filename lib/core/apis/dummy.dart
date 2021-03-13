///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///
///* Github [https://github.com/padong4284]
///*********************************************************************
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/shared/constants.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/service/session.dart';

import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/node/common/user.dart';

University univ = Session.currUniversity;
User user = Session.user;

final String _now = DateTime.now().toIso8601String();

final Map<String, dynamic> statistics = {
  'likes': <String>[],
  'bookmarks': <String>[]
};

/// Node
final Map<String, dynamic> node = {
  //"id": AUTOMATICALLY SET,
  "pip": pipToString(PIP.PUBLIC),
  //"parentId": SET INDIVIDUALLY,
  "ownerId": user.id,
  "createdAt": _now,
  "modifiedAt": _now,
  "deletedAt": null,
};

final Map<String, dynamic> titleNode = {
  ...node,
  'title': 'Title',
  'description': 'This is a *description*, I love PADONG!'
};

/// Deck
final Map<String, dynamic> deck = {
  ...node,
};

final Map<String, dynamic> board = {
  ...titleNode,
  'rule': 'When user write the post at this board, must follow this rule!',
};

final Map<String, dynamic> post = {
  ...titleNode,
  ...statistics,
  'anonymity': false,
  'isNotice': false,
};

final Map<String, dynamic> reply = {
  ...node,
  ...statistics,
  'anonymity': false,
  'description': 'This is a *description*, I love PADONG!',
};

final Map<String, dynamic> reReply = {
  ...reply,
  'bookmarks': null,
};

/// Cover
final Map<String, dynamic> cover = {
  ...node,
};

final Map<String, dynamic> wiki = {
  ...titleNode,
  ...statistics,
  'backLinks': <String>[],
  'frontLinks': <String>[],
};

final Map<String, dynamic> item = {
  ...post,
  'anonymity': false, // fixed
  'deleted': 15,
  'inserted': 15,
  'prevDescription': 'This is a **description**, You love PADONG!'
};

final Map<String, dynamic> argue = {
  ...reply,
  'anonymity': false, // fixed
  'isClosed': false,
};

/// Schedule
final Map<String, dynamic> schedule = {
  ...node,
};

final Map<String, dynamic> event = {
  ...board,
  'rule': MEMO_RULE,
  'periodicity': periodicityToString(PERIODICITY.ANNUALLY),
  'times': <String>['2021-03-12 | 00:30 ~ 23:30'],
  'alerts': <String>['08:30'],
};

final Map<String, dynamic> memo = {
  ...post,
  'pip': pipToString(PIP.INTERNAL),
};

final Map<String, dynamic> lecture = {
  ...event,
  'rule': ASK_RULE,
  'periodicity': periodicityToString(PERIODICITY.WEEKLY),
  'professor': 'Seongbin Hong',
  'room': 'Klaus 304',
  'grade': 'absolute',
  'exam': '3times',
  'attendance': 'randomly',
  'book': 'Title of Book',
};

final Map<String, dynamic> question = {
  ...post,
};

final Map<String, dynamic> evaluation = {
  ...post,
  'rate': 3.5,
};

final Map<String, dynamic> review = {
  ...reply,
  'anonymity': true,
  'rate': 3.5,
};

/// Map
final Map<String, dynamic> mappa = {
  ...node,
};

final Map<String, dynamic> building = {
  ...titleNode,
  ...statistics,
  'location': LatLng(33.775792835163144, -84.3962589592725).toJson(),
  'serviceCheckBits': 13,
};

final Map<String, dynamic> service = {
  ...evaluation,
  'serviceCode': serviceToString(SERVICE(2)),
};

/// Chat
final Map<String, dynamic> message = {
  ...node,
  'message': 'This is a chatting message! I love all of you guys.',
  'isImage': false,
};

final Map<String, dynamic> chatRoom = {
  ...titleNode,
  'lastMessage': null,
};

final Map<String, dynamic> participant = {
  ...node,
  'role': roleToString(ROLE.STUDENT),
};

/// Common
final Map<String, dynamic> userD = {
  ...node,
  'name': 'Daewoong Ko',
  'userId': 'kodw0402',
  'isVerified': true,
  'entranceYear': 2017,
  'userEmails': ['kod0402@gatech.edu'],
  'profileImageURL':
      'https://avatars.githubusercontent.com/u/36005723?s=460&u=49590ea0e7bb1936d515ed627867e8ca217b145b&v=4',
  'friendIds': <String>[],
};

final Map<String, dynamic> university = {
  ...titleNode,
  'title': 'Georgia Tech',
  'description': 'Progress and Service',
  'emblemImgURL':
      'https://en.wikipedia.org/wiki/File:Georgia_Tech_seal.svg',
  'location': LatLng(33.775792835163144, -84.3962589592725).toJson(),
  'address': 'North Ave NW,\nAtlanta, GA 30332',
};

final Map<String, dynamic> like = {
  ...node,
  'parentType': 'post',
};

final Map<String, dynamic> bookmark = {
  ...like,
};

final Map<String, dynamic> subscribe = {
  ...like,
};


