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
import 'package:padong/ui/template/board_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/card/lecture_card.dart';
import 'package:padong/ui/widget/dialog/lecture_dialog.dart';
import 'package:padong/ui/widget/tile/notice_tile.dart';

class LectureView extends StatefulWidget {
  final Lecture lecture;

  LectureView(this.lecture);

  _LectureViewState createState() => _LectureViewState();
}

class _LectureViewState extends State<LectureView> {
  @override
  Widget build(BuildContext context) {
    return BoardTemplate(
        widget.lecture,
        Question(),
        setState,
        writeMessage: 'ask',
        postsMessage: 'Q&A',
        emptyMessage: 'You can ask anything!',
        onPressMore: () => LectureDialog.show(context, widget.lecture),
        actions: [
          IconButton(
              icon: Icon(Icons.mode_comment_outlined,
                  color: AppTheme.colors.support),
              onPressed: () async {
                ChatRoom chatRoom = await widget.lecture.getChatRoom();
                PadongRouter.routeURL('/chatroom?id=${chatRoom.id}', chatRoom);
              }),
        ],
        center: [
          Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: LectureCard(widget.lecture, isToReview: true)),
          Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: NoticeTile(widget.lecture)),
        ],
    );
  }
}
