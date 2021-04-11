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
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/dialog/base_dialog.dart';

class AskNoticeDialog extends StatelessWidget {
  AskNoticeDialog();

  static Future<bool> show(BuildContext context) async {
    return (await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AskNoticeDialog();
            })) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      children: [
        Text('Would you like to post as an Notice?',
            style: AppTheme.getFont(
                fontSize: AppTheme.fontSizes.mlarge, isBold: true))
      ],
      actions: [
        Button('Yes',
            onTap: () => Navigator.pop(context, true),
            color: AppTheme.colors.primary),
        SizedBox(height: 5),
        Button("No",
            shadow: false,
            onTap: () => Navigator.pop(context, false),
            borderColor: AppTheme.colors.pointRed)
      ],
    );
  }
}
