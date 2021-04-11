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
import 'package:padong/core/node/cover/argue.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/dialog/more_dialog.dart';

class ArgueDialog extends MoreDialog {
  final Argue argue;

  ArgueDialog(this.argue) : super(argue);

  static void show(BuildContext context, Argue argue) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ArgueDialog(argue);
        });
  }

  @override
  List<Widget> actions(BuildContext context) {
    return [
      ...super.actions(context),
      SizedBox(height: 5),
      Button(this.argue.isClosed ? 'Reopen' : 'Close',
          color: this.argue.isClosed
              ? AppTheme.colors.pointYellow
              : AppTheme.colors.support,
          onTap: () => this.toggleClosed(context))
    ];
  }

  void toggleClosed(BuildContext context) async {
    this.argue.isClosed = !this.argue.isClosed;
    if (await this.argue.update()) {
      PadongRouter.refresh();
      this.popResultMessage(context,
          'You ${this.argue.isClosed ? 'Close' : 'Reopen'} the Argue', 1);
    }
    else
      this.popResultMessage(
          context, 'Failed to close argue. Please try again.', 0);
  }
}
