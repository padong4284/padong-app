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
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';
import 'package:padong/ui/widgets/tiles/base_tile.dart';

import 'package:padong/core/apis/deck.dart';

class BoardListTile extends StatefulWidget {
  final List<String> boardIds;
  final List<IconData> icons;
  final bool isAlertTile;
  final bool isLecture;

  BoardListTile(
      {@required List<String> boardIds,
      List<IconData> icons,
      isAlertTile = false,
      isLecture = false})
      : assert(isAlertTile || isLecture || (boardIds.length == icons.length)),
        assert(!isLecture || !isAlertTile),
        this.boardIds = boardIds,
        this.icons = icons,
        this.isAlertTile = isLecture || isAlertTile,
        this.isLecture = isLecture;

  @override
  _BoardListTileState createState() => _BoardListTileState();
}

class _BoardListTileState extends State<BoardListTile> {
  List<bool> notifications;

  @override
  void initState() {
    super.initState();
    this.notifications = List.generate(widget.boardIds.length, (_) {
      return false; // get notification or not from firebase
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseTile(
        children: List.generate(
      widget.boardIds.length,
      (idx) {
        final node = widget.isLecture
            ? getLectureAPI(widget.boardIds[idx])
            : getBoardAPI(widget.boardIds[idx]);
        return InkWell(
            onTap: () {
              PadongRouter.routeURL(
                  '/${widget.isLecture ? 'lecture' : 'board'}?id=${node['id']}');
            },
            child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: widget.isAlertTile
                          ? ToggleIconButton(
                              defaultIcon: Icons.notifications,
                              toggleIcon: Icons.notifications_off,
                              isToggled: !node['notification'],
                              defaultColor: AppTheme.colors.pointYellow,
                              toggleColor: AppTheme.colors.support,
                              size: 25,
                              onPressed: () {
                                node['notification'] = !node['notification'];
                                setNotificationBoardAPI(
                                    node['id'], node['notification']);
                              })
                          : Icon(widget.icons[idx],
                              size: 25, color: AppTheme.colors.support)),
                  this.boardText(node['title'])
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
