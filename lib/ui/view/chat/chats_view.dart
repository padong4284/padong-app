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
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/floating_bottom_button.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/chat_room_tile.dart';

class ChatsView extends StatefulWidget {
  final User me;

  ChatsView() : this.me = Session.user;

  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) =>
            PadongButton(isScrollingDown: isScrollingDown, bottomPadding: 40),
        floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
            title: 'Chat',
            onTap: () {
              PadongRouter.refresh = () => setState(() {});
              PadongRouter.routeURL('/chat');
            },
            isScrollingDown: isScrollingDown),
        appBar: BackAppBar(title: 'Chats', actions: [
          IconButton(
              icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
              onPressed: () {}) // TODO: more dialog
        ]),
        children: [
          PadongFutureBuilder(
              future: widget.me.getMyChatRooms(widget.me),
              builder: (chatRooms) => Column(children: <Widget>[
                    ...chatRooms.map((chatRoom) => ChatRoomTile(chatRoom))
                  ]))
        ]);
  }
}
