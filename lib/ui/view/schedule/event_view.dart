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
import 'package:padong/core/node/schedule/event.dart';
import 'package:padong/core/node/schedule/memo.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/floating_bottom_button.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/card/event_card.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/node/post_tile.dart';

class EventView extends StatelessWidget {
  final Event event;

  EventView(this.event);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) =>
            PadongButton(isScrollingDown: isScrollingDown, bottomPadding: 40),
        floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
            title: 'Memo',
            onTap: () => PadongRouter.routeURL(
                'memo?id=${this.event.id}&type=event', this.event),
            isScrollingDown: isScrollingDown),
        appBar: BackAppBar(title: this.event.title, actions: [
          IconButton(
              icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
              onPressed: () {
                PadongRouter.routeURL(
                    '/update?id=${this.event.id}&type=event', this.event);
              }) // TODO: more dialog
        ]),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
            child: Text(this.event.description, style: AppTheme.getFont()),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: EventCard(this.event)),
          TitleHeader('Memos'),
          PadongFutureBuilder(
              future: this.event.getChildren(Memo()),
              builder: (memos) => Column(
                    children: memos.map((memo) => PostTile(memo, url: 'post')),
                  ))
        ]);
  }
}
