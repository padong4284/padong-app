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
import 'package:flutter/cupertino.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/ui/widget/card/photo_card.dart';
import 'package:padong/ui/widget/container/horizontal_scroller.dart';

class ResultView extends StatelessWidget {
  final List<TitleNode> result;
  final String emptyMessage;

  ResultView(this.result, bool isSearched)
      : this.emptyMessage =
            isSearched ? 'Nothing to Show you' : 'You can Search by Title';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HorizontalScroller(
          emptyMessage: this.emptyMessage,
          children: this.result.map((node) => PhotoCard(node)).toList())
    ]);
  }
}
