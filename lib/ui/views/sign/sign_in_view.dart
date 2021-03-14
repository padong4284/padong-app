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
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/views/sign/sign_view.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String idErrorText = "";
  String pwErrorText = "";
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  bool alertId = false;
  bool alertPw = false;

  _setAlerT() {
    setState(() {
      alertId = true;
      alertPw = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SignView(
      true,
      "Welcome\nBack",
      Positioned(
          bottom: 140 + MediaQuery.of(context).padding.bottom,
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  width: MediaQuery.of(context).size.width -
                      2 * (AppTheme.horizontalPadding + 30),
                  child: Column(children: [
                    Input(
                      controller: _idController,
                      hintText: 'ID',
                      errorText:
                          this.idErrorText == "" ? null : this.idErrorText,
                    ),
                    Input(
                      controller: _pwController,
                      margin: EdgeInsets.only(top: 10.0),
                      obsecure: true,
                      hintText: 'Password',
                      errorText:
                          this.pwErrorText == "" ? null : this.pwErrorText,
                    )
                  ])))),
      this.onSignIn,
    );
  }

  _setErrorMessage(int index, String message) {
    setState(() {
      if (index == 0) {
        this.idErrorText = message;
      } else if (index == 1) {
        this.pwErrorText = message;
      }
    });
  }

  _resetErrorTexts() {
    _setErrorMessage(0, "");
    _setErrorMessage(1, "");
  }

  Future<bool> onSignIn() async {
    String id = _idController.text;
    String pw = _pwController.text;
    _resetErrorTexts();

    if (id == "") {
      _setErrorMessage(0, "id is empty");
      return false;
    }

    if (pw == "") {
      _setErrorMessage(1, "pw is empty");
      return false;
    }

    SignInResult result = await Session.signInUser(id, pw);
    if (result == SignInResult.success) return true;

    _setErrorMessage(1, "Wrong id or password");
    //if (result == SignInResult.)
    return false;
  }
}
