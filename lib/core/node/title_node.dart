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
import 'package:padong/core/node/mixin/owner.dart';

class TitleNode extends Node with Owner {
  String title;
  String description;

  TitleNode();

  TitleNode.fromMap(String id, Map snapshot)
      : this.title = snapshot['title'],
        this.description = snapshot['description'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => TitleNode.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'title': this.title,
      'description': this.description,
    };
  }

  // Work with [lib/util/http/img_url_checker.dart]'
  List<String> getImageUrls() {
    List<String> result = [];
    var extractedImgurls = RegExp(
        "!\\[[^\\]]*\]\\((?<filename>.*?)(?=\\\"|\\))(?<optionalpart>\\\".*\\\")?\\)");
    for (var i in extractedImgurls.allMatches(this.description))
      result.add(i.namedGroup("filename"));
    return result;
  }
}
