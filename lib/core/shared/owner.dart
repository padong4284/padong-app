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

mixin Owner on Node {
  User _owner;

  Future<User> get owner async {
    // Node does not get owner directly,
    // because Node never depends on User (Node is super class)
    if (this._owner == null) {
      DocumentSnapshot ownerDoc = await PadongFB.getDoc('user', this.ownerId);
      this._owner = User.fromMap(ownerDoc.id, ownerDoc.data());
    }
    return this._owner;
  }
}
