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
import 'package:padong/core/node/chat/chat_room.dart';
import 'package:padong/core/node/chat/participant.dart';
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/service/padong_fb.dart';

// parent: University
class User extends Node {
  String name;
  String userId;
  bool isVerified;
  String university;
  int entranceYear;
  List<String> userEmails;
  String profileImageURL;
  List<String> friendIds; // send (not received)
  List<String> lectureIds;

  // memoization
  List<Post> _writtens;
  List<Board> _myBoards; // replied, liked, bookmarked

  User();

  User.fromMap(String id, Map snapshot)
      : this.name = snapshot['name'],
        this.userId = snapshot['userId'],
        this.isVerified = snapshot['isVerified'],
        this.university = snapshot['university'],
        this.entranceYear = snapshot['entranceYear'],
        this.userEmails = <String>[...(snapshot['userEmails'] ?? [])],
        this.profileImageURL = snapshot['profileImageURL'],
        this.friendIds = <String>[...(snapshot['friendIds'] ?? [])],
        this.lectureIds = <String>[...(snapshot['lectureIds'] ?? [])],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => User.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'name': this.name,
      'userId': this.userId,
      'isVerified': this.isVerified,
      'university': this.university,
      'entranceYear': this.entranceYear,
      'userEmails': this.userEmails,
      'profileImageURL': this.profileImageURL,
      'friendIds': this.friendIds,
      'lectureIds': this.lectureIds,
    };
  }

  static Future<User> getByUserId(String userId) async {
    List<DocumentSnapshot> users = (await PadongFB.getDocsByRule(User().type,
        rule: (query) => query.where("userId", isEqualTo: userId), limit: 1));
    if (users.isEmpty) return null;
    return User.fromMap(users.first.id, users.first.data());
  }

  RELATION getRelationWith(User me) {
    bool iSendToThis = me.friendIds.contains(this.id);
    bool iReceivedFromThis = this.friendIds.contains(me.id);
    if (iReceivedFromThis) {
      if (iSendToThis) return RELATION.FRIEND;
      return RELATION.RECEIVED;
    }
    if (iSendToThis) return RELATION.SEND;
    return null;
  }

  Future<List<User>> getMyReceived(User me) async {
    return await PadongFB.getDocsByRule('user',
            rule: (query) => query.where('friendIds', arrayContains: me.id))
        .then((docs) => docs
            .map((doc) => User.fromMap(doc.id, doc.data()))
            .where((user) => !me.friendIds.contains(user.id))
            .toList());
  }

  Future<List<User>> getFriends() async {
    if (this.friendIds.isEmpty) return [];
    return await PadongFB.getDocsByRule('user',
        rule: (query) =>
            query.where(PadongFB.documentId, whereIn: this.friendIds)).then(
        (docs) => docs.map((doc) => User.fromMap(doc.id, doc.data())).toList());
  }

  Future<List<Post>> getWrittens() async {
    if (this._writtens == null)
      this._writtens = await PadongFB.getDocsByRule('post',
              rule: (query) => query.where('ownerId', isEqualTo: this.id))
          .then((docs) =>
              docs.map((doc) => Post.fromMap(doc.id, doc.data())).toList());
    return this._writtens;
  }

  Future<List<Board>> getMyBoards(User me) async {
    if (me._myBoards == null) {
      me._myBoards = [];
      /// FIXME: not possible with current node system.
      /// make new type of Node getChildren by Reply, Like, Bookmark
    }
    return this._myBoards;
  }

  Future<List<ChatRoom>> getMyChatRooms(User me) async {
    if (this != me) throw Exception("Not me!");
    List<String> chatRoomIds = [];
    List<DocumentSnapshot> myParticipants = await PadongFB.getDocsByRule(
        Participant().type,
        rule: (query) => query.where('ownerId', isEqualTo: me.id));
    for (DocumentSnapshot p in myParticipants) chatRoomIds.add(p['parentId']);
    if (chatRoomIds.isEmpty) return [];
    return await PadongFB.getDocsByRule(ChatRoom().type,
        rule: (query) =>
            query.where(PadongFB.documentId, whereIn: chatRoomIds)).then(
        (docs) =>
            docs.map((doc) => ChatRoom.fromMap(doc.id, doc.data())).toList());
  }
}
