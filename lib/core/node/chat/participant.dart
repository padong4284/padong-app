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

  int countUnread() {
    // TODO: based on Participant's modifiedAt, message's createdAt
    return 0;
  }
}
