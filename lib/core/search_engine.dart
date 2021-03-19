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
import 'package:flutter/material.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/node/nodes.dart';
import 'package:padong/ui/shared/custom_icons.dart';

class SearchEngine {
  static const Map<String, IconData> level1 = {
    'Padong': CustomIcons.padong,
    'Univ.': Icons.school_rounded,
    'My Own': Icons.person_rounded,
  };

  static const Map<String, Map<String, IconData>> level2 = {
    'Padong': {
      'Univ.': Icons.school_rounded,
      'Wiki': CustomIcons.wiki,
      'Board': Icons.wysiwyg_rounded,
      'Post': Icons.assignment_rounded,
      'Event': Icons.event_rounded,
    },
    'Univ.': {
      'Wiki': CustomIcons.wiki,
      'Board': Icons.wysiwyg_rounded,
      'Post': Icons.assignment_rounded,
      'Event': Icons.event_rounded,
      'Lecture': Icons.menu_book_rounded,
      'Building': Icons.location_city_rounded,
      'Service': Icons.work_rounded,
    },
    'My Own': {
      'User': Icons.person_rounded,
      'Chat': Icons.mode_comment_rounded,
      'Like': Icons.favorite_rounded,
      'Save': Icons.bookmark_rounded,
    }
  };

  static Future<List<TitleNode>> search(String type, String searching) async {
    List<String> keywords =
        searching.split(' ').map((keyword) => keyword.toLowerCase()).toList();
    if (type == 'like' || type == 'bookmark')
      return [
        // TODO: get Post by like and bookmark
      ];
    else if (type == 'chat') type = 'chatroom';
    // TODO: memo & question
    List<TitleNode> nodes = await PadongFB.getDocsByRule(type, limit: 30).then(
        (docs) => <TitleNode>[
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
