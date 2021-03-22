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
import 'package:padong/core/node/schedule/lecture.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/dialog/base_dialog.dart';
import 'package:padong/ui/widget/input/input.dart';

class LectureDialog extends StatelessWidget {
  final Lecture lecture;
  final BuildContext context;
  final bool isMine;
  final bool isEntered;
  final _textController = TextEditingController();

  LectureDialog(this.lecture, this.context)
      : this.isEntered = Session.user.lectureIds.contains(lecture.id),
        this.isMine = Session.user.id == lecture.ownerId;

  static void show(BuildContext context, TitleNode node) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return LectureDialog(node, context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      topTitle: this.lecture.title,
      children: [
        Input(
            controller: this._textController,
            hintText: ' What do you want to report?',
            isMultiline: true,
            type: InputType.PLAIN)
      ],
      actions: [
        this.isMine
            ? Button('Edit', onTap: this.edit, color: AppTheme.colors.support)
            : SizedBox.shrink(),
        SizedBox(height: this.isMine ? 5 : 0),
        Button(this.isEntered ? 'Get Out' : 'Enter',
            onTap: this.enter, color: AppTheme.colors.primary),
      ],
    );
  }

  static String _capitalize(String str) =>
      str[0].toUpperCase() + str.substring(1).toLowerCase();

  void enter() async {
    String lectureId = this.lecture.id;
    assert(this.isEntered == Session.user.lectureIds.contains(lectureId));
    if (this.isEntered)
      Session.user.lectureIds.remove(lectureId);
    else
      Session.user.lectureIds.add(lectureId);
    await Session.user.update();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Get ${this.isEntered ? 'Out' : 'In'} the ${this.lecture.title}')));
    PadongRouter.goBack();
  }

  void edit() {}

  void delete() {}

  void report() {}
}
