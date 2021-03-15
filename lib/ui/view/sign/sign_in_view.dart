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
import 'package:padong/ui/view/sign/base_sign_view.dart';
import 'package:padong/ui/widget/input/input.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  List<String> _errorTexts = [null, null];
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseSignView(
      isSignIn: true,
      welcomeMsg: "Welcome\nBack",
      idErrorText: this._errorTexts[0],
      idController: this._idController,
      onIdChanged: (_) => this._setErrorText(),
      forms: [
        Input(
          isPrivacy: true,
          controller: _pwController,
          margin: EdgeInsets.only(top: 8.0),
          labelText: 'Password',
          errorText: this._errorTexts[1],
          onChanged: (curr) {
            if (curr.isEmpty) this._setErrorText();
          },
        )
      ],
      onTapEnter: this.onSignIn,
    );
  }

  bool _setErrorText([int idx, String errorText]) {
    setState(() {
      this._errorTexts = [null, null];
      if (idx != null) this._errorTexts[idx] = errorText;
    });
    return false;
  }

  Future<bool> onSignIn() async {
    String id = _idController.text;
    String pw = _pwController.text;
    if (id == "") return this._setErrorText(0, "ID is empty.");
    if (pw == "") return this._setErrorText(1, "Password is empty.");

    SignInResult result = await Session.signInUser(id, pw);
    if (result == SignInResult.success) return true;

    if (result == SignInResult.wrongUserId)
      return this._setErrorText(0, "Check your ID.");
    if (result == SignInResult.wrongEmailOrPassword)
      return this._setErrorText(1, "Check your Password.");
    return this._setErrorText(1, "Sorry, failed Sign In.");
  }
}
