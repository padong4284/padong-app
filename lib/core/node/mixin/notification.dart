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
import 'package:padong/core/node/node.dart';
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/shared/types.dart';

mixin Notification on Node {
  List<String> subscribes;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'subscribes': this.subscribes,
    };
  }

  bool isSubscribed(User me) {
    if (this.subscribes.contains(me.id)) return true;
    return false;
  }

  void updateSubscribe(User me) async {
    bool isChecked = this.isSubscribed(me);

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
      thisData['subscribes'] = FieldValue.arrayUnion([me.id]);

      batch.set(PadongFB.getDocRef('subscribe'), data);
      batch.set(PadongFB.getDocRef(this.type, this.id), thisData);
      this.subscribes.add(me.id);
    } else {
      List<DocumentSnapshot> target = await PadongFB.getDocsByRule('subscribe',
          rule: (q) => q
              .where("parentType", isEqualTo: this.type)
              .where("ownerId", isEqualTo: me.id));
      if (target.isNotEmpty)
        batch.delete(PadongFB.getDocRef('subscribe', target.first.id));
      thisData['subscribes'] = FieldValue.arrayRemove([me.id]);
      this.subscribes.remove(me.id);
    }
    await batch.commit();
  }
}
