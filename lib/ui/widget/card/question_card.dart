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
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/bottom_buttons.dart';
import 'package:padong/ui/widget/button/simple_button.dart';
import 'package:padong/ui/widget/card/base_card.dart';
import 'package:padong/ui/widget/node_base.dart';

class QuestionCard extends NodeBase {
  QuestionCard(Post post) : super(post);

  @override
  Widget build(BuildContext context) {
    return BaseCard(
        padding: 10,
        width: // for draggable
            MediaQuery.of(context).size.width - AppTheme.horizontalPadding * 2,
        height: 165,
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              child: Stack(children: [
                Hero(tag: 'node${this.node.id}owner', child: this.profile()),
                Hero(
                    tag: 'node${this.node.id}common', child: this.commonArea()),
                this.messages()
              ])),
          Hero(tag: 'node${this.node.id}bottoms', child: this.bottomArea()),
        ]);
  }

  @override
  Widget followText() {
    return SizedBox.shrink();
  }

  Widget messages() {
    return Padding(
        padding: const EdgeInsets.only(top: 18, left: 45, bottom: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          this.messageBox(this.node.title),
          this.messageBox(this.node.description),
        ]));
  }

  Widget messageBox(String msg) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 50),
        child: Container(
            decoration: BoxDecoration(
                color: AppTheme.colors.lightSupport,
                borderRadius: const BorderRadius.all(Radius.circular(5.0))),
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
            child: Text(
              msg,
              style: AppTheme.getFont(color: AppTheme.colors.fontPalette[1]),
            )));
  }

  @override
  Widget bottomArea({List<int> hides}) {
    return Material(
        color: AppTheme.colors.transparent,
        child: Stack(
          children: [
            BottomButtons(this.node, left: 0, hides: [2]),
            Positioned(
              bottom: 0,
              right: 5,
              child: SimpleButton('Answer ',
                  isSuffixICon: true,
                  buttonSize: ButtonSize.REGULAR,
                  icon: Icon(Icons.send_rounded,
                      color: AppTheme.colors.primary, size: 20),
                  onTap: () =>
                      PadongRouter.routeURL('/post?id=${this.node.id}')),
            )
          ],
        ));
  }
}
