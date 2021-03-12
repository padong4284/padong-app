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
import 'package:padong/core/node/deck/post.dart';

// parent: Lecture (1:1 match)
class Evaluation extends Post {
  double rate;

  Evaluation();

  Evaluation.fromMap(String id, Map snapshot)
      : this.rate = snapshot['rate'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Evaluation.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rate': this.rate,
    };
  }
}
