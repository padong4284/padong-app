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
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/dialog/base_dialog.dart';
import 'package:padong/ui/widget/input/input.dart';

class ForgotDialog extends StatefulWidget {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ForgotDialog();
        });
  }

  _ForgotDialogState createState() => _ForgotDialogState();
}

class _ForgotDialogState extends State<ForgotDialog> {
  String _idError;
  String _emailError;
  TextEditingController _idController;
  TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(children: [
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 5, bottom: 10),
          child: Text('Reset Password',
              style: AppTheme.getFont(
                  fontSize: AppTheme.fontSizes.large, isBold: true))),
      Input(
          controller: this._idController,
          labelText: 'ID',
          errorText: this._idError,
          onChanged: (_) => this.resetError()),
      SizedBox(height: 10),
      Input(
          controller: this._emailController,
          labelText: 'Email',
          errorText: this._emailError,
          onChanged: (_) => this.resetError())
    ], actions: [
      Button('Reset', onTap: () async => await resetPW(context))
    ]);
  }

  Future<void> resetPW(BuildContext context) async {
    String id = this._idController.text;
    String email = this._emailController.text;

    ResetPasswordResult result =
        await Session.sendResetPasswordEmail(id, email);
    if (result == ResetPasswordResult.InvalidUser)
      setState(() => this._idError = 'Please check ID');
    else if (result == ResetPasswordResult.InvalidEmail)
      setState(() => this._emailError = 'Please check Email');
    else if (result == ResetPasswordResult.Failed)
      setState(() =>
          this._emailError = 'Sorry, Email sending failed, Please try again.');
    else {
      Navigator.pop(context); // Success
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Send reset link to $email')));
    }
  }

  void resetError() {
    setState(() {
      this._idError = null;
      this._emailError = null;
    });
  }
}
