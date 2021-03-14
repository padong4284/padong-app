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
import 'package:padong/core/node/deck/board.dart';
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/template/markdown_editor_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/padong_bottom_bar.dart';

class WriteView extends StatelessWidget {
  final Board board;

  WriteView(this.board);

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'write',
      titleHint: 'Title of Post',
      withAnonym: true,
      topArea: this.pipLevel(),
      contentHint: this.board.rule,
      onSubmit: this.createPost,
    );
  }

  Widget pipLevel() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 70,
          height: 30,
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppTheme.colors.primary,
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            pipToString(this.board.pip),
            style: AppTheme.getFont(
                color: AppTheme.colors.base,
                fontSize: AppTheme.fontSizes.small),
          )),
      Text(
        this.board.title,
        style: AppTheme.getFont(isBold: true),
      )
    ]);
  }

  void createPost(Map data) async {
    // TODO: if user is owner of this board, ask isNotice
    // with dialog
    await Post.fromMap('', {
      ...data,
      'parentId': this.board.id,
      'pip': pipToString(this.board.pip),
      'anonymity': TipInfo.isAnonym,
      'isNotice': false,
    }).create();
  }
}
