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
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/node/deck/post.dart';

// parent: Event
class Memo extends Post {
  @override
  PIP pip = PIP.INTERNAL;

  Memo();

  Memo.fromMap(String id, Map snapshot)
      : super.fromMap(id, {...snapshot, 'pip': PIP.INTERNAL});

  @override
  generateFromMap(String id, Map snapshot) => Memo.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'pip': PIP.INTERNAL,
    };
  }
}
