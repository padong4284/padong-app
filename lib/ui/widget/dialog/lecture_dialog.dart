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
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/dialog/more_dialog.dart';

class LectureDialog extends MoreDialog {
  final Lecture lecture;
  final bool isEntered;

  LectureDialog(this.lecture)
      : this.isEntered = Session.user.lectureIds.contains(lecture.id),
        super(lecture, 'update');

  static void show(BuildContext context, Lecture lecture) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return LectureDialog(lecture);
        });
  }

  @override
  List<Widget> actions(BuildContext context) {
    return [
      ...super.actions(context),
      SizedBox(height: this.isMine ? 5 : 0),
      Button(this.isEntered ? 'Get Out' : 'Enter',
          onTap: () => this.enter(context), color: AppTheme.colors.primary),
    ];
  }

  void enter(BuildContext context) async {
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
}
