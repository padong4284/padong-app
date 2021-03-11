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
import 'package:padong/core/node/deck/reply.dart';

// parent: Evaluation
class Review extends Reply {
  @override // always anonymous!
  bool anonymity = true;
  double rate;

  Review();

  Review.fromMap(String id, Map snapshot)
      : this.rate = snapshot['rate'],
        super.fromMap(id, {...snapshot, 'anonymity': true});

  @override
  generateFromMap(String id, Map snapshot) => Review.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': true,
      'rate': this.rate,
    };
  }

  @override
  Future<bool> update() async {
    // TODO: transaction to update Evaluation's rate
    return await super.update();
  }
}
