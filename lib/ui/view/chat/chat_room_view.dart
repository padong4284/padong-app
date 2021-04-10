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
import 'package:padong/core/service/padong_notification.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/container/infinity_scroller.dart';
import 'package:padong/ui/widget/input/bottom_sender.dart';
import 'package:padong/ui/widget/tile/chat_balloon.dart';

class ChatRoomView extends StatefulWidget {
  final ChatRoom chatRoom;
  final TextEditingController _msgController = TextEditingController();

  ChatRoomView(this.chatRoom);

  _ChatRoomViewState createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  Stream messageStream;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    PadongRouter.refresh = this.updateUnread;
    PadongNotification.currentChatRoomId = widget.chatRoom.id;
    widget.chatRoom
        .getMessageStream()
        .then((stream) => setState(() => this.messageStream = stream));
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      isReversed: true,
      stackScrollController: this._scrollController,
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
            this._scrollController.animateTo(
                  0.0,
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 500),
                );
          }),
      stackChildren: [
        Padding(
            padding: const EdgeInsets.only(
              bottom: 70,
              left: AppTheme.horizontalPadding,
              right: AppTheme.horizontalPadding,
            ),
            child: InfinityScroller(widget.chatRoom, Message(),
                seriesBuilder: (message, next, prev) =>
                    ChatBalloon(message, prev: prev, next: next),
                isReversed: true,
                endPadding: 0,
                emptyMessage: '',
                scrollController: this._scrollController,
                preWidgets: [
                  StreamBuilder(
                      stream: this.messageStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox.shrink();
                        } else {
                          List<Message> messages = <Message>[
                            ...snapshot.data.docs.map(
                                (doc) => Message.fromMap(doc.id, doc.data()))
                          ];
                          int len = messages.length;
                          return Column(
                              children: List.generate(
                                  len,
                                  (idx) => ChatBalloon(
                                        messages[idx],
                                        prev:
                                            idx > 0 ? messages[idx - 1] : null,
                                        next: idx < len - 1
                                            ? messages[idx + 1]
                                            : null,
                                      )));
                        }
                      })
                ]))
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    PadongNotification.currentChatRoomId = null;
  }

  void updateUnread() async {
    // TODO: to make unread clear using Participant
  }
}
