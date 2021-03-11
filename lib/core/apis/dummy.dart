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
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/shared/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final String _now = DateTime.now().toIso8601String();

final Map<String, dynamic> _statistics = {
  'likes': <String>[],
  'bookmarks': <String>[]
};

/// Node
final Map<String, dynamic> _node = {
  "id": 'ID_OF_NODE_0000',
  "pip": pipToString(PIP.PUBLIC),
  "parentId": 'ID_OF_PARENT_0000',
  "ownerId": 'ID_OF_USER_0001',
  "createdAt": _now,
  "modifiedAt": _now,
  "deletedAt": null,
};

final Map<String, dynamic> _titleNode = {
  ..._node,
  'title': 'Title',
  'description': 'This is a *description*, I love PADONG!'
};

/// Deck
final Map<String, dynamic> _deck = {
  ..._node,
};

final Map<String, dynamic> _board = {
  ..._titleNode,
  'rule': 'When user write the post at this board, must follow this rule!',
};

final Map<String, dynamic> _post = {
  ..._titleNode,
  ..._statistics,
  'anonymity': false,
  'isNotice': false,
};

final Map<String, dynamic> _reply = {
  ..._node,
  ..._statistics,
  'anonymity': false,
  'description': 'This is a *description*, I love PADONG!',
};

final Map<String, dynamic> _reReply = {
  ..._reply,
  'bookmarks': null,
  'grandParentId': 'ID_OF_GRANDPARENT_0000',
};

/// Cover
final Map<String, dynamic> _cover = {
  ..._node,
};

final Map<String, dynamic> _wiki = {
  ..._titleNode,
  ..._statistics,
  'backLinks': <String>[],
  'frontLinks': <String>[],
};

final Map<String, dynamic> _item = {
  ..._post,
  'anonymity': false, // fixed
  'deleted': 15,
  'inserted': 15,
  'prevDescription': 'This is a **description**, You love PADONG!'
};

final Map<String, dynamic> _argue = {
  ..._reply,
  'anonymity': false, // fixed
  'isClosed': false,
  'wikiId': 'ID_OF_WIKI_0000',
};

/// Schedule
final Map<String, dynamic> _schedule = {
  ..._node,
};

final Map<String, dynamic> _event = {
  ..._board,
  'rule': MEMO_RULE,
  'periodicity': periodicityToString(PERIODICITY.ANNUALLY),
  'times': <String>['2021-03-12 | 00:30 ~ 23:30'],
  'alerts': <String>['08:30'],
};

final Map<String, dynamic> _lecture = {
  ..._event,
  'rule': ASK_RULE,
  'periodicity': periodicityToString(PERIODICITY.WEEKLY),
  'professor': 'Seongbin Hong',
  'room': 'Klaus 304',
  'grade': 'absolute',
  'exam': '3times',
  'attendance': 'randomly',
  'book': 'Title of Book',
};

final Map<String, dynamic> _question = {
  ..._post,
};

final Map<String, dynamic> _evaluation = {
  ..._post,
  'rate': 3.5,
};

final Map<String, dynamic> _review = {
  ..._reply,
  'anonymity': true,
  'rate': 3.5,
};

/// Map
final Map<String, dynamic> _mappa = {
  ..._node,
};

final Map<String, dynamic> _building = {
  ..._titleNode,
  ..._statistics,
  'location': LatLng(33.775792835163144, -84.3962589592725).toJson(),
  'serviceCheckBits': 13,
};

final Map<String, dynamic> _service = {
  ..._evaluation,
  'serviceCode': serviceToString(SERVICE(2)),
};

/// Chat
final Map<String, dynamic> _message = {
  ..._node,
  'message': 'This is a chatting message! I love all of you guys.',
  'isImage': false,
};

final Map<String, dynamic> _chatRoom = {
  ..._titleNode,
  'lastMessage': _message,
};

final Map<String, dynamic> _participant = {
  ..._node,
  'role': roleToString(ROLE.STUDENT),
};

/// Common
final Map<String, dynamic> _user = {
  ..._node,
  'name': 'Daewoong Ko',
  'userId': 'kodw0402',
  'isVerified': true,
  'entranceYear': 2017,
  'userEmails': ['kod0402@gatech.edu'],
  'profileImageURL':
      'https://avatars.githubusercontent.com/u/36005723?s=460&u=49590ea0e7bb1936d515ed627867e8ca217b145b&v=4',
  'friendIds': <String>[],
};

final Map<String, dynamic> _university = {
  ..._titleNode,
  'title': 'Georgia Tech',
  'description': 'Progress and Service',
  'emblemImgURL': 'https://en.wikipedia.org/wiki/File:Georgia_Tech_seal.svg',
  'location': LatLng(33.775792835163144, -84.3962589592725).toJson(),
  'address': 'North Ave NW,\nAtlanta, GA 30332',
};

final Map<String, dynamic> _like = {
  ..._node,
  'parentType': 'post',
};

final Map<String, dynamic> _bookmark = {
  ..._like,
};

final Map<String, dynamic> _subscribe = {
  ..._like,
};