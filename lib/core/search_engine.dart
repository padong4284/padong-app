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
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/node/nodes.dart';

class SearchEngine {
  static Future<List<TitleNode>> search(String type, String searching) async {
    List<String> keywords =
        searching.split(' ').map((keyword) => keyword.toLowerCase()).toList();
    if (type == 'like' || type == 'bookmark')
      return [
        // TODO: get Post by like and bookmark
      ];
    List<TitleNode> nodes = await PadongFB.getDocsByRule(type).then((docs) =>
        <TitleNode>[
          ...docs.map((doc) => Nodes.generateNode(type, doc.id, doc.data()))
        ]);

    // only searching title
    List<TitleNode> result = [];
    for (TitleNode node in nodes) {
      String title = node.title.toLowerCase();
      if (title.isEmpty) continue;
      if (keywords.contains(title))
        result.add(node); // title is match with keyword
      else
        for (String keyword in keywords)
          if (title.contains(keyword) || keyword.contains(title)) {
            result.add(node); // contain keyword
            break;
          }
    }
    return result;
  }
}
