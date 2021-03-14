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
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/core/node/deck/re_reply.dart';
import 'package:padong/core/node/deck/reply.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/node/re_reply_tile.dart';
import 'package:padong/ui/widget/tile/node/reply_tile.dart';

class ReReplyFocus {
  static String replyId;

  static void initialize() {
    replyId = null;
  }
}

class ReplyView extends StatefulWidget {
  final Post post;
  final FocusNode focus;

  ReplyView(this.post, {this.focus});

  _ReplyViewState createState() => _ReplyViewState();
}

class _ReplyViewState extends State<ReplyView> {
  bool isRendered = false;
  List<Reply> replies;
  Map<String, bool> readyReReply = {};
  Map<String, GlobalKey> replyKeys = {};

  @override
  void initState() {
    super.initState();
    widget.post.getChildren(Reply()).then((replies) => setState(() {
          this.replies = <Reply>[...replies];
          for (Reply reply in replies) {
            this.readyReReply[reply.id] = false;
            this.replyKeys[reply.id] = new GlobalKey();
          }
        }));
    this.isRendered = false;
    this.setRendered();
  }

  void setRendered() async {
    await Future.delayed(Duration(milliseconds: 600));
    setState(() {
      this.isRendered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.focus.hasFocus) setState(() => this.initReplyFocus());
    return AnimatedOpacity(
        opacity: this.isRendered ? 1 : 0,
        duration: Duration(milliseconds: 400),
        child: Column(children: [
          ...(this.replies ?? []).map((reply) {
            return PadongFutureBuilder(
              future: reply.getChildren(ReReply()),
              builder: (reReplies) => Column(children: [
                GestureDetector(
                    onTap: () {
                      bool next = !this.readyReReply[reply.id];
                      FocusScope.of(context).unfocus();
                      if (next && widget.focus != null)
                        widget.focus.requestFocus();
                      setState(() {
                        this.initReplyFocus();
                        this.readyReReply[reply.id] = next;
                        ReReplyFocus.replyId = next ? reply.id : null;
                      });
                      this.scrollToReply(reply.id);
                    },
                    child: Container(
                        key: this.replyKeys[reply.id],
                        color: this.readyReReply[reply.id]
                            ? AppTheme.colors.semiPrimary
                            : null,
                        child: ReplyTile(reply))),
                ...<ReReply>[...reReplies]
                    .map((reReply) => ReReplyTile(reReply))
              ]),
            );
          }),
          SizedBox(height: 65)
        ]));
  }

  void scrollToReply(String rid) async {
    await Future.delayed(Duration(milliseconds: 200));
    Scrollable.ensureVisible(this.replyKeys[rid].currentContext);
  }

  void initReplyFocus() {
    for (Reply reply in (this.replies ?? []))
      this.readyReReply[reply.id] = false;
    ReReplyFocus.initialize();
  }
}
