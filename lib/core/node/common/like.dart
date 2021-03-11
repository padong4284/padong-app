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

// parent: Post, Reply, ReReply
class Like extends Node {
  String parentType;

  Like();

  Like.fromMap(String id, Map snapshot)
      : this.parentType = snapshot['parentType'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Like.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {'parentType': this.parentType, ...super.toJson()};
  }
}
