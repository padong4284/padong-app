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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/chat/message.dart';
import 'package:padong/core/node/chat/participant.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/shared/notification.dart';
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/shared/types.dart';

// parent: Lecture or null
class ChatRoom extends TitleNode with Notification {
  Message lastMessage;

  Future<List<User>> get participants async {
    List<User> result = [];
    List<Participant> _participants = <Participant>[
      ...(await this.getChildren(Participant()))
    ];
    for (Participant participant in _participants)
      result.add(await participant.owner);
    return result;
  }

  ChatRoom();

  ChatRoom.fromMap(String id, Map snapshot)
      : this.lastMessage = snapshot['lastMessage'] != null
            ? Message.fromMap(
                snapshot['lastMessage']['id'], snapshot['lastMessage'])
            : null,
        super.fromMap(id, snapshot) {
    this.subscribes = <String>[...snapshot['subscribes']];
  }

  @override
  generateFromMap(String id, Map snapshot) => ChatRoom.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'lastMessage': this.lastMessage?.toJson(),
    };
  }

  Future<Participant> invite(User user, [String role]) async {
    return await Participant.fromMap('', {
      'pip': pipToString(this.pip),
      'parentId': this.id,
      'ownerId': user.id,
      'role': role ?? "Student",
    }).create();
  }

  Future<bool> chatMessage(User me, String msg, {bool isImage = false}) async {
    Message message = await Message.fromMap('', {
      'pip': pipToString(this.pip),
      'parentId': this.id,
      'ownerId': me.id,
      'message': msg,
      'isImage': isImage
    }).create();
    if (message == null) return false;
    this.lastMessage = message;
    return await this.update();
  }

  Stream<QuerySnapshot> getMessageStream() {
    return PadongFB.getQueryStreamByRule(
      Message().type,
      rule: (query) => query
          .where("parentId", isEqualTo: this.id)
          .orderBy("createdAt", descending: true),
      limit: 30,
    );
  }

  Future<int> countUnread(User me) async {
    // TODO: based on Participant's modifiedAt, message's createdAt
    return 0;
  }
}
