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
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/dialog/base_dialog.dart';
import 'package:padong/ui/widget/input/input.dart';

// Post, Reply, ReReply, Argue
class MoreDialog extends StatelessWidget {
  final bool isMine;
  final Node node;
  final _textController = TextEditingController();
  final String editUrl;

  MoreDialog(this.node, [this.editUrl])
      : this.isMine = node.ownerId == Session.user.id;

  static void show(BuildContext context, Node node, {String editUrl}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MoreDialog(node, editUrl);
        });
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      topTitle: this.getTitle(),
      children: [
        this.isMine
            ? SizedBox.shrink()
            : Input(
                controller: this._textController,
                hintText: ' What do you want to report?',
                isMultiline: true,
                type: InputType.PLAIN)
      ],
      actions: this.actions(context),
    );
  }

  String getTitle() {
    if (this.node is TitleNode) {
      TitleNode tNode = this.node as TitleNode;
      if (tNode.title.isNotEmpty) return tNode.title;
    }
    if (this.node is User) return (this.node as User).userId;
    return _capitalize(this.node.type);
  }

  List<Widget> actions(BuildContext context) {
    return [
      this.isMine && (this.editUrl != null)
          ? Button('Edit', onTap: this.edit, color: AppTheme.colors.support)
          : SizedBox.shrink(),
      SizedBox(height: this.isMine ? 5 : 0),
      this.isMine
          ? Button('Delete',
              shadow: false,
              onTap: () => this.delete(context),
              borderColor: AppTheme.colors.pointRed)
          : Button('Report', onTap: () => this.report(context))
    ];
  }

  static String _capitalize(String str) =>
      str[0].toUpperCase() + str.substring(1).toLowerCase();

  void edit() {
    PadongRouter.routeURL(
        '/${this.editUrl}?id=${this.node.id}&type=${this.node.type}',
        this.node);
  }

  void delete(BuildContext context) async {
    if (await this.node.delete())
      this.popResultMessage(context, 'Delete Completed', 2);
    else
      this.popResultMessage(context, 'Delete Failed', 0);
  }

  void report(BuildContext context) async {
    String email = Session.user.userEmails[0];
    String title = 'Report about ${this.node.type} ${this.node.id}';
    String body = 'From: $email\n${this._textController.text}';
    if (await Session.sendReport(title, body, ['report']))
      this.popResultMessage(context, 'Report Success, We will reply to $email');
    else
      this.popResultMessage(context, 'Report Failed, Please retry.', 0);
  }

  void popResultMessage(BuildContext context, String message,
      [int goBack = 1]) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    for (int _ = 0; _ < goBack; _++) Navigator.pop(context);
  }
}
