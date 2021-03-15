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
import 'package:padong/core/node/chat/chat_room.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/profile_button.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/node/node_tile.dart';

class ChatRoomTile extends NodeTile {
  final ChatRoom chatRoom;

  ChatRoomTile(this.chatRoom) : super(chatRoom, withStatistics: false);

  @override
  void routePage() =>
      PadongRouter.routeURL('chatroom?id=${this.chatRoom.id}', this.chatRoom);

  @override
  Widget profile() {
    return PadongFutureBuilder(
        future: this.chatRoom.participants,
        builder: (participants) {
          List<User> others = participants
              .where((participant) => participant.ownerId != Session.user.id)
              .toList();
          int len = others.length;
          double size = len > 2 ? 20.0 : (55.0 - len * 15);
          others += [null, null, null, null];
          return Stack(children: [
            SizedBox(width: 40, height: 40),
            Positioned(
                top: 0,
                child: this.profileLine(
                    [others[0], others[3]],
                    size,
                    len > 2
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start)),
            Positioned(
                bottom: 0,
                child: this.profileLine(
                    [others[1], others[2]], size, MainAxisAlignment.end))
          ]);
        });
  }

  Widget profileLine(List<User> users, double size, MainAxisAlignment align) {
    return Container(
        width: 40,
        child: Row(mainAxisAlignment: align, children: [
          users[0] != null
              ? ProfileButton(users[0], size: size)
              : SizedBox.shrink(),
          users[1] != null
              ? ProfileButton(users[1], size: size)
              : SizedBox.shrink(),
        ]));
  }

  @override
  Widget topText() {
    return Text(this.chatRoom.title,
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(color: AppTheme.colors.semiSupport));
  }

  @override
  Widget followText() {
    return Text(this.chatRoom.lastMessage.message,
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(color: AppTheme.colors.support));
  }

  @override
  Widget bottomArea({List<int> hides}) {
    return PadongFutureBuilder(
        future: this.chatRoom.countUnread(Session.user),
        builder: (unread) =>
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox.shrink(),
              unread > 0
                  ? Container(
                      height: 20,
                      margin:
                          const EdgeInsets.only(right: 5, top: 2, bottom: 3),
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
                          )))
                  : SizedBox(height: 20)
            ]));
  }
}
