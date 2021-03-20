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
import 'package:padong/core/node/schedule/lecture.dart';
import 'package:padong/core/node/schedule/question.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/floating_bottom_button.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/card/lecture_card.dart';
import 'package:padong/ui/widget/component/no_data_message.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/node/post_tile.dart';
import 'package:padong/ui/widget/tile/notice_tile.dart';

class LectureView extends StatefulWidget {
  final Lecture lecture;

  LectureView(this.lecture);

  _LectureViewState createState() => _LectureViewState();
}

class _LectureViewState extends State<LectureView> {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) =>
          PadongButton(isScrollingDown: isScrollingDown, bottomPadding: 40),
      floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
          title: 'Ask',
          onTap: () {
            PadongRouter.refresh = () => setState(() {});
            PadongRouter.routeURL(
                'ask?id=${widget.lecture.id}&type=lecture', widget.lecture);
          },
          isScrollingDown: isScrollingDown),
      appBar: BackAppBar(title: widget.lecture.title, actions: [
        IconButton(
            icon: Icon(Icons.mode_comment_outlined,
                color: AppTheme.colors.support),
            onPressed: () async {
              ChatRoom chatRoom = await widget.lecture.getChatRoom();
              PadongRouter.routeURL('/chatroom?id=${chatRoom.id}', chatRoom);
            }),
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {
              PadongRouter.routeURL(
                  '/update?id=${widget.lecture.id}&type=lecture',
                  widget.lecture);
            }) // TODO: more dialog
      ]),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: Text(widget.lecture.description, style: AppTheme.getFont()),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: LectureCard(widget.lecture, isToReview: true)),
        Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: NoticeTile(widget.lecture)),
        TitleHeader('Q&A'),
        PadongFutureBuilder(
            future: widget.lecture.getChildren(Question(), upToDate: true),
            builder: (questions) => Column(children: [
                  questions.isEmpty
                      ? NoDataMessage('You can ask anything!', height: 100)
                      : SizedBox.shrink(),
                  ...questions
                      .map((question) => PostTile(question, url: 'post'))
                ]))
      ],
    );
  }
}
