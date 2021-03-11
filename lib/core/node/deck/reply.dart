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
import 'package:padong/core/shared/statistics.dart';

// parent: Post
class Reply extends Node with Statistics {
  bool anonymity; // hide profile
  String description;

  Reply();

  Reply.fromMap(String id, Map snapshot)
      : this.anonymity = snapshot['anonymity'],
        this.description = snapshot['description'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Reply.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': this.anonymity,
      'description': this.description,
    };
  }

  @override
  Future<List<int>> getStatistics() async {
    List<int> statistics = await super.getStatistics();
    statistics[2] = null;
    return statistics;
  }
}
