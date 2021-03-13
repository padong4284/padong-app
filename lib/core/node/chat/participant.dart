import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/common/user.dart';
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
import 'package:padong/core/node/node.dart';
import 'package:padong/core/shared/types.dart';

// parent: ChatRoom
class Participant extends Node {
  ROLE role;

  User _user;

  Future<User> get owner async {
    // Node does not get owner directly,
    // because Node never depends on User (Node is super class)
    if (this._user == null) {
      DocumentSnapshot userDoc = await this.ownerDoc;
      this._user = User.fromMap(userDoc.id, userDoc.data());
    }
    return this._user;
  }

  Participant();

  Participant.fromMap(String id, Map snapshot)
      : this.role = parseROLE(snapshot['role']),
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Participant.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'role': roleToString(this.role),
    };
  }
}
