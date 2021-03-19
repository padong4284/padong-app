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
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/deck/re_reply.dart';
import 'package:padong/core/node/deck/reply.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/shared/types.dart';

mixin Statistics on TitleNode {
  List<String> likes;
  List<String> bookmarks;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'likes': this.likes ?? [],
      'bookmarks': this.bookmarks ?? [],
    };
  }

  bool isLiked(User me) {
    if (this.likes == null) return false;
    if (this.likes.contains(me.id)) return true;
    return false;
  }

  bool isBookmarked(User me) {
    if (this.bookmarks == null) return false;
    if (this.bookmarks.contains(me.id)) return true;
    return false;
  }

  Future<bool> isReplied(User me) async {
    switch (this.type) {
      case "post":
        {
          return (await PadongFB.getDocsByRule("reply",
              rule: (q) => q
                  .where("parentId", isEqualTo: this.id)
                  .where("ownerId", isEqualTo: me.id),
              limit: 1)).isNotEmpty || (await PadongFB.getDocsByRule("rereply",
              rule: (q) => q
                  .where("grandParentId", isEqualTo: this.id)
                  .where("ownerId", isEqualTo: me.id),
              limit: 1)).isNotEmpty;
        }
        break;
      case "reply":
        {
          var result= (await PadongFB.getDocsByRule("rereply",
              rule: (q) => q
                  .where("parentId", isEqualTo: this.id)
                  .where("ownerId", isEqualTo: me.id),
              limit: 1));
          return result.isNotEmpty;
        }
        break;
      case "building":
        {
          return (await PadongFB.getDocsByRule("service",
              rule: (q) => q
                  .where("parentId", isEqualTo: this.id)
                  .where("ownerId", isEqualTo: me.id),
              limit: 1)).isNotEmpty;
        }
        break;
      case "wiki":
        {
          return (await PadongFB.getDocsByRule("item",
              rule: (q) => q
                  .where("parentId", isEqualTo: this.id)
                  .where("ownerId", isEqualTo: me.id),
              limit: 1)).isNotEmpty;
        }
        break;
    }
    return false;
  }

  Future<void> _update(User me, int _likeOrBookmark) async {
    String _targetType = _likeOrBookmark == 0 ? 'like' : 'bookmark';
    bool isChecked = [this.isLiked, this.isBookmarked][_likeOrBookmark](me);

    Map<String, dynamic> thisData = this.toJson();
    Map<String, dynamic> data = new Map<String, dynamic>();
    WriteBatch batch = PadongFB.getBatch();

    if (!isChecked) {
      data = {
        'parentType': this.type,
        'pip': pipToString(PIP.PUBLIC),
        'parentId': this.id,
        'ownerId': me.id,
        'createdAt': DateTime.now().toIso8601String(),
      };
      thisData['${_targetType}s'] = FieldValue.arrayUnion([me.id]);

      batch.set(PadongFB.getDocRef(_targetType), data);
      [this.likes, this.bookmarks][_likeOrBookmark].add(me.id);
    } else {
      List<DocumentSnapshot> target = await PadongFB.getDocsByRule(_targetType,
          rule: (q) => q
              .where("parentType", isEqualTo: this.type)
              .where("ownerId", isEqualTo: me.id),
          limit: 1);
      if (target.isNotEmpty)
        batch.delete(PadongFB.getDocRef(_targetType, target.first.id));
      thisData['${_targetType}s'] = FieldValue.arrayRemove([me.id]);
      [this.likes, this.bookmarks][_likeOrBookmark].remove(me.id);
    }
    batch.set(PadongFB.getDocRef(this.type, this.id), thisData);
    await batch.commit();
  }

  Future<void> updateLiked(User me) async {
    // TODO: update view
    if (this.likes != null) await this._update(me, 0);
  }

  Future<void> updateBookmarked(User me) async {
    if (this.bookmarks != null) await this._update(me, 1);
  }

  Future<List<int>> getStatisticsWithoutMe(User me) async {
    List<Node> replyResult = await this.getChildren(Reply());
    List<DocumentSnapshot> reReplyResult = (await PadongFB.getDocsByRule(
          "rereply",
          rule: (q) => q.where("grandParentId", isEqualTo: this.id)));
    List<Node> reReplyChildrenResult = await this.getChildren(ReReply());


    return [
      // no count me
      (this.likes ?? []).where((id) => id != me.id).length,
      replyResult.length + reReplyResult.length + reReplyChildrenResult.length - ((await this.isReplied(me))?1:0),
      (this.bookmarks ?? []).where((id) => id != me.id).length,
    ];
  }
}
