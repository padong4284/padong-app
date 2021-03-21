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
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/dialog/base_dialog.dart';
import 'package:padong/ui/widget/input/input.dart';

class MoreDialog extends StatelessWidget {
  final bool isMine;
  final TitleNode node;
  final _textController = TextEditingController();

  MoreDialog(this.node) : this.isMine = node.ownerId == Session.user.id;

  static void show(BuildContext context, TitleNode node) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MoreDialog(node);
        });
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      topTitle: this.node.title.isNotEmpty
          ? this.node.title
          : _capitalize(this.node.type),
      children: [
        this.isMine
            ? SizedBox.shrink()
            : Input(
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
        this.isMine
            ? Button('Delete',
                shadow: false,
                onTap: this.delete,
                borderColor: AppTheme.colors.pointRed)
            : Button('Report', onTap: this.report)
      ],
    );
  }

  static String _capitalize(String str) =>
      str[0].toUpperCase() + str.substring(1).toLowerCase();

  void edit() {}

  void delete() {}

  void report() {}
}
