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
import 'package:padong/core/shared/constants.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/dialog/base_dialog.dart';
import 'package:padong/ui/widget/padong_markdown.dart';

class TermsDialog extends StatelessWidget {
  TermsDialog();

  static Future<bool> show(BuildContext context) async {
    return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return TermsDialog();
        })) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      children: [
        PadongMarkdown(TERMS)
      ],
      actions: [
        Button('Yes, I agree.',
            onTap: () => Navigator.pop(context, true),
            color: AppTheme.colors.primary),
        SizedBox(height: 5),
        Button("No, I don't",
            shadow: false,
            onTap: () => Navigator.pop(context, false),
            borderColor: AppTheme.colors.pointRed)
      ],
    );
  }
}
