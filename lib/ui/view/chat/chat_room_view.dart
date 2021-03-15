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
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/input/bottom_sender.dart';

class ChatRoomView extends StatefulWidget {
  final ChatRoom chatRoom;
  final TextEditingController _msgController = TextEditingController();

  ChatRoomView(this.chatRoom);

  _ChatRoomViewState createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  @override
  void initState() {
    super.initState();
    PadongRouter.refresh = this.updateParticipant;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> msgs = []; // ChatBalloon
    return SafePaddingTemplate(
      appBar: BackAppBar(title: widget.chatRoom.title, isClose: true, actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {}) // TODO: more dialog
      ]),
      floatingBottomBar: BottomSender(BottomSenderType.CHAT,
          msgController: widget._msgController, onSubmit: () {
        // TODO: send and receive messages !
        widget._msgController.text = '';
      }),
      children: [...msgs, SizedBox(height: 40)],
    );
  }

  void updateParticipant() async {
    // TODO: to make unread clear
  }
}
