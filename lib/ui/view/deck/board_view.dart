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
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/ui/template/board_template.dart';
import 'package:padong/ui/widget/tile/notice_tile.dart';

class BoardView extends StatefulWidget {
  final Board board;

  BoardView(this.board);

  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  @override
  Widget build(BuildContext context) {
    return BoardTemplate(
        widget.board,
        Post(),
        setState,
        onPressMore: () {}, // TODO: more dialog
        center: [
          Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: NoticeTile(widget.board)),
        ],
    );
  }
}
