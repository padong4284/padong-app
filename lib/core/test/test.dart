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
import 'package:padong/core/node/chat/chat_room.dart';
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
import 'package:padong/core/test/dummy.dart';

Future<void> deckTesting() async {
  // Deck
  Deck _deck = await Deck.fromMap('', {...deck, 'parentId': univ.id}).create();
  Board _board =
      await Board.fromMap('', {...board, 'parentId': _deck.id}).create();
  Post _post =
      await Post.fromMap('', {...post, 'parentId': _board.id}).create();
  Reply _reply =
      await Reply.fromMap('', {...reply, 'parentId': _post.id}).create();
  ReReply _reReply = await ReReply.fromMap('', {
    ...reReply,
    'parentId': _reply.id,
    'grandParentId': _reply.parentId
  }).create();
}

Future<void> coverTesting() async {
  // Cover
  Cover _cover =
      await Cover.fromMap('', {...cover, 'parentId': univ.id}).create();
  Wiki _wiki =
      await Wiki.fromMap('', {...wiki, 'parentId': _cover.id}).create();
  Item _item = await Item.fromMap('', {...item, 'parentId': _wiki.id}).create();
  Argue _argue = await Argue.fromMap(
      '', {...argue, 'parentId': _item.id, 'wikiId': _wiki.id}).create();
  ReReply _reReply = await ReReply.fromMap('', {
    ...reReply,
    'parentId': _argue.id,
    'grandParentId': _argue.parentId
  }).create();
}

Future<void> mappaTest() async {
  // Mappa
  Mappa _mappa =
      await Mappa.fromMap('', {...mappa, 'parentId': univ.id}).create();
  Building _building =
      await Building.fromMap('', {...building, 'parentId': _mappa.id}).create();
  Service _service =
      await Service.fromMap('', {...service, 'parentId': _building.id}).create();
  Review _review =
      await Review.fromMap('', {...review, 'parentId': _service.id}).create();
  ReReply _reReply = await ReReply.fromMap('', {
    ...reReply,
    'parentId': _review.id,
    'grandParentId': _review.parentId
  }).create();
}

Future<void> scheduleTest() async {
  // Schedule
  Schedule _schedule =
      await Schedule.fromMap('', {...schedule, 'parentId': univ.id}).create();
  Lecture _lecture =
      await Lecture.fromMap('', {...lecture, 'parentId': _schedule.id}).create();
  Question _question =
      await Question.fromMap('', {...question, 'parentId': _lecture.id})
          .create();
  Reply _reply =
      await Reply.fromMap('', {...reply, 'parentId': _question.id}).create();
  ReReply _reReply = await ReReply.fromMap('', {
    ...reReply,
    'parentId': _reply.id,
    'grandParentId': _reply.parentId
  }).create();
  Evaluation _evaluation =
      await Evaluation.fromMap('', {...evaluation, 'parentId': _lecture.id})
          .create();
  Review _review =
      await Review.fromMap('', {...review, 'parentId': _evaluation.id}).create();
  ReReply _reReply1 = await ReReply.fromMap('', {
    ...reReply,
    'parentId': _review.id,
    'grandParentId': _review.parentId
  }).create();
  Event _eventU =
      await Event.fromMap('', {...event, 'parentId': user.id}).create();
  Event _event =
      await Event.fromMap('', {...event, 'parentId': _schedule.id}).create();
  Memo _memo = await Memo.fromMap('', {...memo, 'parentId': _event.id}).create();
  Reply _reply1 =
      await Reply.fromMap('', {...reply, 'parentId': _memo.id}).create();
  ReReply _reReply2 = await ReReply.fromMap('', {
    ...reReply,
    'parentId': _reply1.id,
    'grandParentId': _reply1.parentId
  }).create();
}

Future<void> chatTesting() async {
  ChatRoom _chatRoom =
      await ChatRoom.fromMap('', {...chatRoom, 'parentId': ''}).create();
  _chatRoom.invite(user);
  _chatRoom.chatMessage(user, 'this is the chatting message');
}

Future<void> dummyTesting() async {
  await deckTesting();
  await coverTesting();
  await mappaTest();
  await scheduleTest();
  await chatTesting();
}
