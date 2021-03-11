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
import 'package:padong/core/apis/chat.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';
import 'package:padong/core/apis/session.dart' as Session;

class ChatRoomTile extends NodeBaseTile {
  final String id;
  final Map<String, dynamic> chatRoom;

  ChatRoomTile(chatRoomId)
      : this.id = chatRoomId,
        this.chatRoom = getChatRoomAPI(chatRoomId),
        super(chatRoomId);

  @override
  void routePage() => PadongRouter.routeURL('chat_room?id=${this.id}');

  @override
  Widget profile() {
    List<String> others = this
        .chatRoom['participants']
        .where((id) => id != Session.user['id'])
        .toList();
    int len = others.length;
    double size = len > 2 ? 20.0 : (55.0 - len * 15);
    others += [null, null, null];
    return Stack(
      children: [
        SizedBox(width: 40, height: 40),
        Positioned(
            top: 0,
            child: this.profileLine([others[0], others[3]], size,
                len > 2 ? MainAxisAlignment.center : MainAxisAlignment.start)),
        Positioned(
            bottom: 0,
            child: this.profileLine(
                [others[1], others[2]], size, MainAxisAlignment.end))
      ],
    );
  }

  Widget profileLine(List<String> users, double size, MainAxisAlignment align) {
    return Container(
        width: 40,
        child: Row(mainAxisAlignment: align, children: [
          users[0] != null
              ? UserProfileButton(users[0], size: size)
              : SizedBox.shrink(),
          users[1] != null
              ? UserProfileButton(users[1], size: size)
              : SizedBox.shrink(),
        ]));
  }

  @override
  Widget topText() {
    return Text(this.chatRoom['title'],
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(color: AppTheme.colors.semiSupport));
  }

  @override
  Widget followText() {
    return Text(this.chatRoom['messages'][0]['message'],
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(color: AppTheme.colors.support));
  }

  @override
  Widget bottomArea() {
    int unread = this.chatRoom['unreads'];
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox.shrink(),
      unread > 0
          ? Container(
              height: 20,
              margin: const EdgeInsets.only(right: 5, top: 2, bottom: 3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppTheme.colors.pointRed,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                    unread.toString(),
                    textAlign: TextAlign.center,
                    style: AppTheme.getFont(
                        color: AppTheme.colors.base,
                        fontSize: AppTheme.fontSizes.small),
                  )),
            )
          : SizedBox.shrink()
    ]);
  }
}
