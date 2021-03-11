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
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/tiles/chat_balloon.dart';

class ChatRoomView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> chatRoom;
  final TextEditingController _msgController = TextEditingController();

  ChatRoomView(id)
      : this.id = id,
        this.chatRoom = getChatRoomAPI(id);

  @override
  Widget build(BuildContext context) {
    updateChatRoomAPI(this.id); // unread = 0
    List<Widget> msgs = [];
    List<Map> messages = this.chatRoom['messages'].reversed.toList();
    for (int i = 0; i < messages.length; i++) {
      Map chatMsg = messages[i];
      msgs.add(ChatBalloon(chatMsg,
          prev: i > 0 ? messages[i - 1] : null,
          next: i < messages.length - 1 ? messages[i + 1] : null));
    }
    return SafePaddingTemplate(
      appBar:
          BackAppBar(title: this.chatRoom['title'], isClose: true, actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {}) // TODO: more dialog
      ]),
      floatingBottomBar: BottomSender(
        BottomSenderType.CHAT,
        msgController: this._msgController,
        onSubmit: () {
          // TODO: send and receive messages !
          this._msgController.text = '';
        },
      ),
      children: [...msgs, SizedBox(height: 40)],
    );
  }
}
