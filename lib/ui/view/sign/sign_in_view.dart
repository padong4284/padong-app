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
import 'package:padong/ui/view/sign/base_sign_view.dart';
import 'package:padong/ui/widget/input/input.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new BaseSignView(
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
                    Input(controller: _idController, hintText: 'ID'),
                    Input(
                        controller: _pwController,
                        margin: EdgeInsets.only(top: 10.0),
                        hintText: 'Password')
                  ])))),
      this.onSignIn,
    );
  }

  Future<bool> onSignIn() async {
    String id = _idController.text;
    String pw = _pwController.text;

    // TODO: validate check
    SignInResult result = await Session.signInUser(id, pw);
    if (result == SignInResult.success) return true;
    return false;
  }
}