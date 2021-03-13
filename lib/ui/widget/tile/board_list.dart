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
import 'package:padong/core/node/common/subscribe.dart';
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/toggle_icon_button.dart';
import 'package:padong/ui/widget/tile/base_tile.dart';

class BoardList extends StatefulWidget {
  final List<Board> boards;
  final List<IconData> icons;
  final bool isAlerts;
  final bool isLecture;

  BoardList(
      {@required List<Board> boards, List<IconData> icons, isLecture = false})
      : this.boards = boards,
        this.icons = icons,
        this.isAlerts = isLecture || (icons == null),
        this.isLecture = isLecture;

  @override
  _BoardListState createState() => _BoardListState();
}

class _BoardListState extends State<BoardList> {
  List<bool> subscribes;

  @override
  void initState() {
    super.initState();
    this.subscribes = List.generate(widget.boards.length, (_) => false);
    Session.user.getChildren(Subscribe()).then((subscribes) {
      setState(() {
        for (int idx = 0; idx < widget.boards.length; idx++)
          this.subscribes[idx] = subscribes.contains(widget.boards[idx]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseTile(
        children: List.generate(
      widget.boards.length,
      (idx) {
        Board board = widget.boards[idx];
        return InkWell(
            onTap: () => PadongRouter.routeURL('/${board.type}?id=${board.id}'),
            child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: widget.isAlerts
                          ? ToggleIconButton(Icons.notifications,
                              toggleIcon: Icons.notifications_off,
                              isToggled: !board.isSubscribed(Session.user),
                              defaultColor: AppTheme.colors.pointYellow,
                              toggleColor: AppTheme.colors.support,
                              size: 25, onPressed: () {
                              board.updateSubscribe(Session.user, false);
                            })
                          : Icon(widget.icons[idx],
                              size: 25, color: AppTheme.colors.support)),
                  this.boardText(board.title)
                ])));
      },
    ));
  }

  Text boardText(text) {
    return Text(text,
        textAlign: TextAlign.left,
        style: AppTheme.getFont(
            color: AppTheme.colors.support,
            fontSize: AppTheme.fontSizes.mlarge));
  }
}
