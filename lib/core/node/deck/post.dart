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
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/shared/statistics.dart';

// parent: Board
class Post extends TitleNode with Statistics {
  bool anonymity; // hide profile
  bool isNotice;

  Post();

  Post.fromMap(String id, Map snapshot)
      : this.anonymity = snapshot['anonymity'],
        this.isNotice = snapshot['isNotice'],
        super.fromMap(id, snapshot) {
    this.likes = <String>[...snapshot['likes']];
    this.bookmarks = <String>[...snapshot['bookmarks']];
  }

  @override
  generateFromMap(String id, Map snapshot) => Post.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'anonymity': this.anonymity,
      'isNotice': this.isNotice,
    };
  }
}
