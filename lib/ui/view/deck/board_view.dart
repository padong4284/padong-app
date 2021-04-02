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
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/floating_bottom_button.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/component/no_data_message.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/container/infinity_scroller.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/padong_markdown.dart';
import 'package:padong/ui/widget/tile/node/post_tile.dart';
import 'package:padong/ui/widget/tile/notice_tile.dart';

class BoardView extends StatefulWidget {
  final Board board;
  final ACCESS access;

  BoardView(this.board) : this.access = Session.checkAccess(board);

  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) =>
            PadongButton(isScrollingDown: isScrollingDown, bottomPadding: 40),
        floatingBottomBarGenerator: widget.access == ACCESS.READWRITE
            ? (isScrollingDown) => FloatingBottomButton(
                title: 'Write',
                onTap: () { // register refresh to update
                  PadongRouter.refresh = () => setState(() {});
                  PadongRouter.routeURL(
                      'write?id=${widget.board.id}&type=board', widget.board);
                },
                isScrollingDown: isScrollingDown)
            : null,
        appBar: BackAppBar(title: widget.board.title, actions: [
          IconButton(
              icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
              onPressed: () {}) // TODO: more dialog
        ]),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
            child: PadongMarkdown(widget.board.description),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: NoticeTile(widget.board)),
          TitleHeader('Posts'),
          InfinityScroller(
              widget.board,
              Post(),
              builder: (post) => PostTile(post as Post))
          /*
          PadongFutureBuilder(
              future: widget.board.getChildren(Post(), upToDate: true),
              builder: (posts) => Column(children: <Widget>[
                    posts.length == 0
                        ? NoDataMessage('Please write first Post!', height: 100)
                        : SizedBox.shrink(),
                    ...posts.map((post) => PostTile(post))
                  ]))
          */
        ]);
  }
}
