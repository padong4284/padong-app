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
import 'package:padong/ui/widget/input/input.dart';

class NoUnivDialog extends StatefulWidget {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NoUnivDialog();
        });
  }

  _NoUnivDialogState createState() => _NoUnivDialogState();
}

class _NoUnivDialogState extends State<NoUnivDialog> {
  TextEditingController _univController;
  TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _univController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(children: [
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 5, bottom: 10),
          child: Text('Your University',
              style: AppTheme.getFont(
                  fontSize: AppTheme.fontSizes.large, isBold: true))),
      Input(controller: this._univController, labelText: 'University'),
      SizedBox(height: 10),
      Input(controller: this._emailController, labelText: 'Email')
    ], actions: [
      Button('Request', onTap: () async => await resetPW(context))
    ]);
  }

  Future<void> resetPW(BuildContext context) async {
    String university = this._univController.text;
    String email = this._emailController.text;

    // TODO: send email to padong4284@gmail.com

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('We will send the response to $email')));
  }
}
