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
import 'package:padong/core/node/chat/message.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/profile_button.dart';
import 'package:padong/ui/widget/button/simple_button.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/util/time_manager.dart';

class ChatBalloon extends StatelessWidget {
  // TODO: img!
  final bool isMine;
  final bool hideTimestamp;
  final bool hideSender;
  final Message chatMsg;

  ChatBalloon(this.chatMsg, {Message prev, Message next})
      : this.isMine = Session.user.id == chatMsg.ownerId,
        this.hideTimestamp = checkHideTimestamp(chatMsg, next),
        this.hideSender = checkHideSender(prev, chatMsg);

  @override
  Widget build(BuildContext context) {
    List<Widget> message = [
      chatMsg.isImage
          ? this.imageMessage(context)
          : this.messageBox(this.isMine)
    ];
    if (!this.hideTimestamp) message.add(this.timestamp(this.isMine));
    return Container(
        padding: EdgeInsets.only(top: this.hideSender ? 0 : 10),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                this.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              this.isMine ? SizedBox.shrink() : this.sender(),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                this.isMine || this.hideSender
                    ? SizedBox.shrink()
                    : PadongFutureBuilder(
                        future: this.chatMsg.owner,
                        builder: (owner) => Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              (owner as User).userId,
                              style: AppTheme.getFont(
                                  color: AppTheme.colors.fontPalette[1]),
                            ))),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [...(this.isMine ? message.reversed : message)])
              ])
            ]));
  }

  Widget messageBox(bool isMine) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 218),
        child: Container(
            decoration: BoxDecoration(
                color: isMine
                    ? AppTheme.colors.primary
                    : AppTheme.colors.lightSupport,
                borderRadius: const BorderRadius.all(Radius.circular(5.0))),
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
            child: Text(
              this.chatMsg.message,
              style: AppTheme.getFont(
                  color: isMine
                      ? AppTheme.colors.fontPalette[4]
                      : AppTheme.colors.fontPalette[1]),
            )));
  }

  Widget timestamp(bool isMine) {
    String hNm =
        this.chatMsg.createdAt.toString().split(' ')[1].substring(0, 5);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Text(hNm,
            style: AppTheme.getFont(
                color: isMine
                    ? AppTheme.colors.semiPrimary
                    : AppTheme.colors.fontPalette[3],
                fontSize: AppTheme.fontSizes.small)));
  }

  Widget sender() {
    return Padding(
        padding: const EdgeInsets.only(top: 5, right: 5),
        child: this.hideSender
            ? SizedBox(width: 40)
            : PadongFutureBuilder(
                future: this.chatMsg.owner,
                builder: (owner) => ProfileButton(owner, size: 40)));
  }

  static bool checkHideTimestamp(Message cur, Message next) {
    return next != null
        ? TimeManager.isSameYMDHM(cur.createdAt, next.createdAt)
        : false;
  }

  static bool checkHideSender(Message prev, Message cur) {
    return prev != null
        ? (prev.ownerId == cur.ownerId &&
            TimeManager.isSameYMDHM(prev.createdAt, cur.createdAt))
        : false;
  }

  Widget imageMessage(BuildContext context) {
    double _width =
        MediaQuery.of(context).size.width - AppTheme.horizontalPadding * 2;
    Widget _img(double width) => ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image.network(this.chatMsg.message,
            width: width, fit: BoxFit.fitWidth));
    return InkWell(
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                        margin: const EdgeInsets.only(top: 15),
                        width: 25,
                        height: 25,
                        child: SimpleButton('',
                            icon: Icon(Icons.close_rounded,
                                color: AppTheme.colors.base, size: 25),
                            onTap: () => Navigator.pop(context))),
                    Expanded(child: _img(_width))
                  ]));
            }),
        child: _img(200.0));
  }
}
