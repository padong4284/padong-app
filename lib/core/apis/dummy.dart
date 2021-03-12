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

import 'package:padong/core/node/chat/chat_room.dart';
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/cover/argue.dart';
import 'package:padong/core/node/cover/cover.dart';
import 'package:padong/core/node/cover/item.dart';
import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/deck/deck.dart';
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/core/node/deck/re_reply.dart';
import 'package:padong/core/node/deck/reply.dart';
import 'package:padong/core/node/map/building.dart';
import 'package:padong/core/node/map/mappa.dart';
import 'package:padong/core/node/map/service.dart';
import 'package:padong/core/node/schedule/evaluation.dart';
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/lecture.dart';
import 'package:padong/core/node/schedule/memo.dart';
import 'package:padong/core/node/schedule/question.dart';
import 'package:padong/core/node/schedule/review.dart';
import 'package:padong/core/node/schedule/schedule.dart';

University univ = Session.currUniversity;
User user = Session.user;

final String _now = DateTime.now().toIso8601String();

final Map<String, dynamic> _statistics = {
  'likes': <String>[],
  'bookmarks': <String>[]
};

/// Node
final Map<String, dynamic> _node = {
  //"id": AUTOMATICALLY SET,
  "pip": pipToString(PIP.PUBLIC),
  //"parentId": SET INDIVIDUALLY,
  "ownerId": user.id,
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

final Map<String, dynamic> _memo = {
  ..._post,
  'pip': pipToString(PIP.INTERNAL),
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
  'lastMessage': null,
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
  'emblemImgURL':
      'https://en.wikipedia.org/wiki/File:Georgia_Tech_seal.svg',
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


Future<void> deckTesting() async {
  // Deck
  Deck deck = await Deck.fromMap('', {..._deck, 'parentId': univ.id}).create();
  Board board =
  await Board.fromMap('', {..._board, 'parentId': deck.id}).create();
  Post post =
  await Post.fromMap('', {..._post, 'parentId': board.id}).create();
  Reply reply =
  await Reply.fromMap('', {..._reply, 'parentId': post.id}).create();
  ReReply reReply = await ReReply.fromMap('', {
    ..._reReply,
    'parentId': reply.id,
    'grandParentId': reply.parentId
  }).create();
}

Future<void> coverTesting() async {
  // Cover
  Cover cover =
  await Cover.fromMap('', {..._cover, 'parentId': univ.id}).create();
  Wiki wiki =
  await Wiki.fromMap('', {..._wiki, 'parentId': cover.id}).create();
  Item item = await Item.fromMap('', {..._item, 'parentId': wiki.id}).create();
  Argue argue = await Argue.fromMap(
      '', {..._argue, 'parentId': item.id, 'wikiId': wiki.id}).create();
  ReReply reReply = await ReReply.fromMap('', {
    ..._reReply,
    'parentId': argue.id,
    'grandParentId': argue.parentId
  }).create();
}

Future<void> mappaTest() async {
  // Mappa
  Mappa mappa =
  await Mappa.fromMap('', {..._mappa, 'parentId': univ.id}).create();
  Building building =
  await Building.fromMap('', {..._building, 'parentId': mappa.id})
      .create();
  Service service =
  await Service.fromMap('', {..._service, 'parentId': building.id})
      .create();
  Review review =
  await Review.fromMap('', {..._review, 'parentId': service.id}).create();
  ReReply reReply = await ReReply.fromMap('', {
    ..._reReply,
    'parentId': review.id,
    'grandParentId': review.parentId
  }).create();
}

Future<void> scheduleTest() async {
  // Schedule
  Schedule schedule =
  await Schedule.fromMap('', {..._schedule, 'parentId': univ.id}).create();
  Lecture lecture =
  await Lecture.fromMap('', {..._lecture, 'parentId': schedule.id})
      .create();
  Question question =
  await Question.fromMap('', {..._question, 'parentId': lecture.id})
      .create();
  Reply reply =
  await Reply.fromMap('', {..._reply, 'parentId': question.id}).create();
  ReReply reReply = await ReReply.fromMap('', {
    ..._reReply,
    'parentId': reply.id,
    'grandParentId': reply.parentId
  }).create();
  Evaluation evaluation =
  await Evaluation.fromMap('', {..._evaluation, 'parentId': lecture.id})
      .create();
  Review review =
  await Review.fromMap('', {..._review, 'parentId': evaluation.id})
      .create();
  ReReply reReply1 = await ReReply.fromMap('', {
    ..._reReply,
    'parentId': review.id,
    'grandParentId': review.parentId
  }).create();
  Event eventU =
  await Event.fromMap('', {..._event, 'parentId': user.id}).create();
  Event event =
  await Event.fromMap('', {..._event, 'parentId': schedule.id}).create();
  Memo memo =
  await Memo.fromMap('', {..._memo, 'parentId': event.id}).create();
  Reply reply1 =
  await Reply.fromMap('', {..._reply, 'parentId': memo.id}).create();
  ReReply reReply2 = await ReReply.fromMap('', {
    ..._reReply,
    'parentId': reply1.id,
    'grandParentId': reply1.parentId
  }).create();
}

Future<void> chatTesting() async {
  ChatRoom chatRoom =
  await ChatRoom.fromMap('', {..._chatRoom, 'parentId': ''}).create();
  chatRoom.addParticipant(user);
  chatRoom.chatMessage(user, 'this is the chatting message');
}

Future<void> dummyTesting() async {
  await deckTesting();
  await coverTesting();
  await mappaTest();
  await scheduleTest();
  await chatTesting();
}
