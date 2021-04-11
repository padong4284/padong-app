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
import 'package:padong/core/node/chat/participant.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/dialog/more_dialog.dart';

class ChatRoomDialog extends MoreDialog {
  final ChatRoom chatRoom;

  ChatRoomDialog(this.chatRoom) : super(chatRoom);

  static void show(BuildContext context, ChatRoom chatRoom) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChatRoomDialog(chatRoom);
        });
  }

  @override
  List<Widget> actions(BuildContext context) {
    return [
      Button('Report', onTap: () => this.report(context)),
      SizedBox(height: 5),
      Button('Get Out',
          onTap: () => this.getOut(context),
          borderColor: AppTheme.colors.pointRed)
    ];
  }

  void getOut(BuildContext context) async {
    for (Participant p in (await this.chatRoom.getChildren(Participant())))
      if (p.ownerId == Session.user.id) {
        if (await p.remove()) {
          this.popResultMessage(context, 'Bye!', 0);
          PadongRouter.goBack();
          PadongRouter.goBack();
        }
        else
          this.popResultMessage(context, 'Failed to get out, Please retry.', 0);
        break;
      }
  }
}
