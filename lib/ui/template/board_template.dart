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
import 'package:padong/core/node/schedule/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/floating_bottom_button.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/container/infinity_scroller.dart';
import 'package:padong/ui/widget/padong_markdown.dart';
import 'package:padong/ui/widget/tile/node/post_tile.dart';

class BoardTemplate extends StatelessWidget {
  final Board board;
  final Post post;
  final ACCESS access;
  final Function(void Function()) setState;
  final String writeMessage;
  final String postsMessage;
  final String emptyMessage;
  final Function onPressMore;
  final List<Widget> actions;
  final List<Widget> center;
  final ScrollController _controller = ScrollController();

  BoardTemplate(
    this.board,
    this.post,
    this.setState, {
    this.writeMessage = 'write',
    this.postsMessage = 'Posts',
    this.emptyMessage = 'Please write first Post',
    this.onPressMore,
    this.actions,
    this.center,
  }) : this.access = Session.checkAccess(board);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) =>
          PadongButton(isScrollingDown: isScrollingDown, bottomPadding: 40),
      floatingBottomBarGenerator: this.access == ACCESS.READWRITE
          ? (isScrollingDown) => FloatingBottomButton(
              title: this.writeMessage[0].toUpperCase() +
                  this.writeMessage.substring(1).toLowerCase(),
              onTap: () {
                // register refresh to update
                PadongRouter.refresh = () => this.setState(() {});
                PadongRouter.routeURL(
                    '${this.writeMessage.toLowerCase()}?id=${this.board.id}&type=${this.board.type}',
                    this.board);
              },
              isScrollingDown: isScrollingDown)
          : null,
      appBar: BackAppBar(title: this.board.title, actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: this.onPressMore ?? () {}),
        ...(this.actions ?? [])
      ]),
      stackChildren: [
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.horizontalPadding),
            child: InfinityScroller(
              this.board,
              this.post,
              builder: (post) => PostTile(post as Post),
              emptyMessage: this.emptyMessage,
              preWidgets: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
                  child: PadongMarkdown(this.board.description),
                ),
                ...(this.center ?? []),
                TitleHeader(this.postsMessage)
              ],
              scrollController: this._controller,
            ))
      ],
      stackScrollController: this._controller,
    );
  }
}
