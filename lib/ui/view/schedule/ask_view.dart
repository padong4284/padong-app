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
import 'package:padong/core/node/schedule/question.dart';
import 'package:padong/core/shared/constants.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/template/markdown_editor_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/padong_bottom_bar.dart';

class AskView extends StatelessWidget {
  final Lecture lecture;

  AskView(this.lecture);

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'ask',
      titleHint: 'Title of Question',
      contentHint: QUESTION_HINT,
      withAnonym: true,
      topArea: this.lectureInfo(),
      onSubmit: this.createQuestion,
    );
  }

  Widget lectureInfo() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          height: 30,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppTheme.colors.primary,
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            this.lecture.title,
            style: AppTheme.getFont(color: AppTheme.colors.base),
          )),
      Text(
        this.lecture.professor,
        style: AppTheme.getFont(isBold: true),
      )
    ]);
  }

  void createQuestion(Map data) async {
    // TODO: if user is owner of this board, ask isNotice
    // with dialog
    await Question.fromMap('', {
      ...data,
      'parentId': this.lecture.id,
      'pip': pipToString(this.lecture.pip),
      'anonymity': TipInfo.isAnonym,
      'isNotice': false,
    }).create();
  }
}
