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
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/markdown_editor_template.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';

class AskView extends StatelessWidget {
  final String lectureId;
  final Map<String, dynamic> lecture;

  AskView(lectureId)
      : this.lectureId = lectureId,
        this.lecture = getLectureAPI(lectureId);

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'ask',
      titleHint: 'Title of Question',
      contentHint: QuestionHint,
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
            this.lecture['title'],
            style: AppTheme.getFont(color: AppTheme.colors.base),
          )),
      Text(
        this.lecture['professor'],
        style: AppTheme.getFont(isBold: true),
      )
    ]);
  }

  void createQuestion(Map data) {
    data['parentId'] = this.lectureId;
    data['isAnonym'] = TipInfo.isAnonym;
    createPostAPI(data);
  }
}

const String QuestionHint = """You can ask anything!
Question is always Public.

Anyone can see your Question,
and Everyone can help you.

Ask Freely! It's Free!
""";