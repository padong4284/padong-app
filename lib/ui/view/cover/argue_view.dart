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
import 'package:padong/core/node/cover/argue.dart';
import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/core/node/deck/re_reply.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/input/bottom_sender.dart';
import 'package:padong/ui/widget/tile/node/re_reply_tile.dart';
import 'package:padong/ui/widget/tile/node/reply_tile.dart';

class ArgueFocus {
  static String argueId;

  static void initialize() {
    argueId = null;
  }
}

class ArgueView extends StatefulWidget {
  final Wiki wiki;

  ArgueView(this.wiki);

  _ArgueViewState createState() => _ArgueViewState();
}

class _ArgueViewState extends State<ArgueView> {
  List<Argue> opens = [];
  List<Argue> closeds = [];
  Map<String, List<ReReply>> reReplies = {};
  Map<String, GlobalKey> argueKeys = {};
  Map<String, bool> readyReReply = {};
  final TextEditingController _argueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.getArgues();
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingBottomBar: BottomSender(BottomSenderType.ARGUE,
            onSubmit: this.sendArgue,
            msgController: this._argueController,
            afterHide: true),
        children: [
          SizedBox(height: 20),
          TitleHeader('Open'),
          ...argueList(this.opens),
          SizedBox(height: 40),
          TitleHeader('Closed'),
          ...argueList(this.closeds),
          SizedBox(height: 65)
        ]);
  }

  Iterable<Widget> argueList(List<Argue> argues) {
    return argues.map((argue) {
      List<ReReply> reReplies = this.reReplies[argue.id] ?? [];
      return Column(children: [
        GestureDetector(
            onTap: () {
              bool next = !this.readyReReply[argue.id];
              if (this.mounted)
                setState(() {
                  this.initReplyFocus();
                  this.readyReReply[argue.id] = next;
                  ArgueFocus.argueId = next ? argue.id : null;
                });
              this.scrollToReply(argue.id);
            },
            child: Container(
                // TODO: close argue
                key: this.argueKeys[argue.id],
                color: this.readyReReply[argue.id]
                    ? AppTheme.colors.semiPrimary
                    : null,
                child: ReplyTile(argue))),
        ...(this.readyReReply[argue.id]
            ? reReplies.map((reReply) => ReReplyTile(reReply))
            : [])
      ]);
    });
  }

  void scrollToReply(String argueId) async {
    await Future.delayed(Duration(milliseconds: 200));
    Scrollable.ensureVisible(this.argueKeys[argueId].currentContext);
  }

  void initReplyFocus() {
    for (Argue argue in this.opens + this.closeds)
      this.readyReReply[argue.id] = false;
    ArgueFocus.initialize();
  }

  Future<void> getArgues() async {
    List<Argue> _argues = await widget.wiki.argues;
    this.opens = [];
    this.closeds = [];
    for (Argue argue in _argues.reversed) {
      if (argue.isClosed)
        this.closeds.add(argue);
      else
        this.opens.add(argue);
      this.readyReReply[argue.id] = false;
      this.argueKeys[argue.id] = new GlobalKey();
    }
    await this.getReReplies();
    if (this.mounted) setState(() {});
  }

  Future<void> getReReplies() async {
    List<ReReply> _reReplies = <ReReply>[
      ...(await ReReply.getByGrandParent(widget.wiki))
    ];
    this.reReplies = {};
    for (ReReply reReply in _reReplies)
      this.reReplies[reReply.parentId] =
          (this.reReplies[reReply.parentId] ?? []) + [reReply];
  }

  void sendArgue() async {
    if (this._argueController.text.length > 0)
      await [Argue(), ReReply()][ArgueFocus.argueId != null ? 1 : 0]
          .generateFromMap('', {
        'pip': pipToString(widget.wiki.pip),
        'parentId':
            ArgueFocus.argueId ?? (widget.wiki.lastItemId ?? widget.wiki.id),
        'ownerId': Session.user.id,
        'description': this._argueController.text,
        'anonymity': false,
        'grandParentId': widget.wiki.id, // for ReReply
        'likes': [],
        'isClosed': false,
        'wikiId': widget.wiki.id,
      }).create();
    this._argueController.text = '';
    this.getArgues();
  }
}
