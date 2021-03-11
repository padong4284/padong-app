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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/deck/deck.dart';
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/core/node/deck/re_reply.dart';
import 'package:padong/core/node/deck/reply.dart';
import 'package:padong/core/node/cover/argue.dart';
import 'package:padong/core/node/cover/cover.dart';
import 'package:padong/core/node/cover/item.dart';
import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/core/node/schedule/evaluation.dart';
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/lecture.dart';
import 'package:padong/core/node/schedule/memo.dart';
import 'package:padong/core/node/schedule/question.dart';
import 'package:padong/core/node/schedule/review.dart';
import 'package:padong/core/node/schedule/schedule.dart';
import 'package:padong/core/node/map/building.dart';
import 'package:padong/core/node/map/mappa.dart';
import 'package:padong/core/node/map/service.dart';
import 'package:padong/core/node/chat/chat_room.dart';
import 'package:padong/core/node/chat/message.dart';
import 'package:padong/core/node/chat/participant.dart';
import 'package:padong/core/node/common/bookmark.dart';
import 'package:padong/core/node/common/like.dart';
import 'package:padong/core/node/common/subscribe.dart';
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/service/padong_fb.dart';

final List<Node> _nodes = [
  Node(), TitleNode(), // base
  Deck(), Board(), Post(), Reply(), ReReply(), // deck
  Cover(), Wiki(), Item(), Argue(), // cover
  Schedule(), Event(), Memo(), Lecture(), Question(), Evaluation(), Review(), // schedule
  Mappa(), Building(), Service(), // Map
  ChatRoom(), Participant(), Message(), // chat
  User(), University(), Like(), Bookmark(), Subscribe(), // common*/
];

class Nodes {
  Nodes();

  static final Map<String, Node> _nodeMap =
      Map.fromIterable(_nodes, key: (node) => node.type, value: (node) => node);

  Future<Node> getNodeById(String type, String id) async {
    DocumentSnapshot doc = await PadongFB.getDoc(type, id);
    return _nodeMap[type].generateFromMap(doc.id, doc.data());
  }
}
