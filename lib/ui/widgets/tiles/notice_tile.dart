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
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/more_button.dart';
import 'package:padong/ui/widgets/tiles/base_tile.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';

class NoticeTile extends StatefulWidget {
  final List<String> notices;
  final String boardId;

  NoticeTile(boardId)
      : this.boardId = boardId,
        this.notices = getNoticeIdsAPI(boardId);

  @override
  _NoticeTileState createState() => _NoticeTileState();
}

class _NoticeTileState extends State<NoticeTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return BaseTile(children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(Icons.campaign,
                          color: AppTheme.colors.support, size: 25)),
                  Text('Notice',
                      style: AppTheme.getFont(
                          color: AppTheme.colors.support,
                          fontSize: AppTheme.fontSizes.mlarge,
                          isBold: true))
                ],
              ),
              widget.notices.length > 2
                  ? MoreButton('', expanded: this.expanded,
                      expandFunction: () {
                      setState(() {
                        this.expanded = !this.expanded;
                      });
                    })
                  : SizedBox.shrink()
            ],
          )),
      Container(height: 2, color: AppTheme.colors.support),
      ...List.generate(
        this.expanded ? widget.notices.length : 2,
        (idx) => _NoticeTile(widget.notices[idx],
            (this.expanded ?  widget.notices.length : 2) == idx + 1),
      )
    ]);
  }
}

class _NoticeTile extends NodeBaseTile {
  final bool isLast;

  _NoticeTile(id, this.isLast) : super(id, noProfile: true);

  @override
  Widget bottomArea() {
    return SizedBox(height: 5);
  }

  @override
  Widget underLine() {
    return this.isLast
        ? SizedBox.shrink()
        : Container(
            height: 2,
            color: AppTheme.colors.lightSupport,
            margin: const EdgeInsets.only(top: 5));
  }
}
