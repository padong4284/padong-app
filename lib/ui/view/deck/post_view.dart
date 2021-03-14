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
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/view/deck/reply_view.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/bar/padong_bottom_bar.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/input/bottom_sender.dart';
import 'package:padong/ui/widget/padong_markdown.dart';
import 'package:padong/ui/widget/tile/node/post_tile.dart';

class PostView extends PostTile {
  @override
  final Post node;
  final FocusNode focus = FocusNode();
  final TextEditingController _replyController = TextEditingController();

  PostView(this.node) : super(node);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingBottomBar: BottomSender(BottomSenderType.REPLY,
            onSubmit: this.sendReply,
            msgController: this._replyController,
            focus: this.focus,
            afterHide: true),
        appBar: BackAppBar(likeAndBookmark: this.node),
        children: [
          Stack(children: [
            Hero(tag: 'node${this.node.id}owner', child: this.profile()),
            Hero(tag: 'node${this.node.id}common', child: this.commonArea())
          ]),
          TitleHeader(this.node.title,
              link: "/${this.node.type}?id=${this.node.id}"),
          PadongMarkdown(this.node.description),
          SizedBox(height: 20),
          Hero(tag: 'node${this.node.id}bottoms', child: this.bottomArea()),
          this.underLine(),
          ReplyView(this.node, focus: focus)
        ]);
  }

  @override
  Widget commonArea() {
    return Container(
        height: 40,
        padding: EdgeInsets.only(left: 47, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: this.topText()), this.time()],
          )
        ]));
  }

  Widget underLine() {
    return Container(
        height: 2,
        color: AppTheme.colors.lightSupport,
        margin: const EdgeInsets.only(top: 5));
  }

  void sendReply() async {
    if (this._replyController.text.length > 0) {
      await [Reply(), ReReply()][ReReplyFocus.replyId != null ? 1 : 0]
          .generateFromMap('', {
        'pip': pipToString(this.node.pip),
        'parentId': ReReplyFocus.replyId ?? this.node.id,
        'ownerId': Session.user.id,
        'description': this._replyController.text,
        'anonymity': TipInfo.isAnonym,
        'grandParentId': this.node.id, // for ReReply
        'likes': [],
      }).create();
      // TODO: append on view
    }
    this._replyController.text = '';
  }
}
