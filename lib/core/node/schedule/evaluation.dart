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
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/core/node/schedule/review.dart';
import 'package:padong/core/shared/types.dart';

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

  Future<Review> reviewWithRate(User me, String review, double rate) async {
    List<Review> _reviews = <Review>[
      ...(await this.getChildren(Review(), upToDate: true))
    ];
    double _prevRate = (this.rate * _reviews.length);
    for (Review _review in _reviews)
      if (_review.ownerId == me.id) {
        _prevRate -= _review.rate;
        await _review.remove();
        _reviews.remove(_review);
        break;
      }

    Review _rev = await Review.fromMap('', {
      'pip': pipToString(PIP.INTERNAL),
      'parentId': this.id,
      'ownerId': me.id,
      'rate': rate,
      'description': review,
    }).create();
    this.rate = (_prevRate + rate) / (_reviews.length + 1);
    this.update();
    return _rev;
  }
}
