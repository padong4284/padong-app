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
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/validator.dart';
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
  String emailError;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _univController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(children: [
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 5, bottom: 10),
          child: Text('Your University',
              style: AppTheme.getFont(
                  fontSize: AppTheme.fontSizes.large, isBold: true))),
      Input(
          controller: this._emailController,
          labelText: 'Email',
          errorText: emailError,
          onChanged: (_) => setState(() => this.emailError = null),
      ),
      SizedBox(height: 10),
      Input(controller: this._univController, labelText: 'University'),
    ], actions: [
      Button('Request', onTap: () async => await requestUniv(context))
    ]);
  }

  Future<void> requestUniv(BuildContext context) async {
    String result;
    String university = this._univController.text;
    String email = this._emailController.text;

    if (!Validator.isValid(Validator.emailRule, email))
      return setState(() => this.emailError = 'Please Check An Email.');

    if (await Session.sendUnivRequest(email, university)) {
      result = 'We will reply to $email';
      Navigator.pop(context);
    } else
      result = 'Failed, Please retry again';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
  }
}
