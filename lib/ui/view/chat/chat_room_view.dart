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
import 'package:padong/core/node/chat/message.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/input/bottom_sender.dart';
import 'package:padong/ui/widget/tile/chat_balloon.dart';

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
    PadongRouter.refresh = this.updateUnread;
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      isReversed: true,
      appBar: BackAppBar(title: widget.chatRoom.title, isClose: true, actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {}) // TODO: more dialog
      ]),
      floatingBottomBar: BottomSender(BottomSenderType.CHAT,
          msgController: widget._msgController,
          chatImage: (imgURL) =>
              widget.chatRoom.chatMessage(Session.user, imgURL, isImage: true),
          onSubmit: () {
            if (widget._msgController.text.isNotEmpty)
              widget.chatRoom
                  .chatMessage(Session.user, widget._msgController.text);
            widget._msgController.text = '';
          }),
      children: [
        StreamBuilder(
            stream: widget.chatRoom.getMessageStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                List<Message> messages = <Message>[
                  ...snapshot.data.docs.reversed
                      .map((doc) => Message.fromMap(doc.id, doc.data()))
                ];
                int len = messages.length;
                return Column(
                    children: List.generate(
                        len,
                        (idx) => ChatBalloon(
                              messages[idx],
                              prev: idx > 0 ? messages[idx - 1] : null,
                              next: idx < len - 1 ? messages[idx + 1] : null,
                            )));
              }
            }),
        SizedBox(height: 45)
      ],
    );
  }

  void updateUnread() async {
    // TODO: to make unread clear using Participant
  }
}
