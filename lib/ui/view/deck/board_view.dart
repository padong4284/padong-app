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
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/padong_markdown.dart';
import 'package:padong/ui/widget/tile/node/post_tile.dart';
import 'package:padong/ui/widget/tile/notice_tile.dart';

class BoardView extends StatelessWidget {
  final Board board;
  final ACCESS access;

  BoardView(this.board) : this.access = Session.checkAccess(board);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) =>
            PadongButton(isScrollingDown: isScrollingDown, bottomPadding: 40),
        floatingBottomBarGenerator: access == ACCESS.READWRITE
            ? (isScrollingDown) => FloatingBottomButton(
                title: 'Write',
                onTap: () => PadongRouter.routeURL('write?id=${this.board.id}&type=board', this.board),
                isScrollingDown: isScrollingDown)
            : null,
        appBar: BackAppBar(title: this.board.title, actions: [
          IconButton(
              icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
              onPressed: () {}) // TODO: more dialog
        ]),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
            child: PadongMarkdown(this.board.description),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: NoticeTile(this.board)),
          TitleHeader('Posts'),
          PadongFutureBuilder(
              future: this.board.getChildren(Post()),
              builder: (posts) => Column(children: <Widget>[
                    posts.length == 0
                        ? NoDataMessage('Please write first Post!', height: 100)
                        : SizedBox.shrink(),
                    ...posts.map((post) => PostTile(post))
                  ]))
        ]);
  }
}
