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
import 'package:padong/ui/widget/input/list_picker.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final List<TextEditingController> _controllers =
      List.generate(7, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return BaseSignView(
      isSignIn: false,
      welcomeMsg: "Welcome",
      idController: this._controllers[0],
      forms: [
        Input(
            isPrivacy: true,
            controller: this._controllers[1],
            margin: EdgeInsets.only(top: 8.0),
            labelText: 'Password'),
        Input(
            isPrivacy: true,
            controller: this._controllers[2],
            margin: EdgeInsets.only(top: 8.0),
            labelText: 'Repeat Password'),
        // TODO: check match feedback real-time
        Input(
            controller: this._controllers[3],
            margin: EdgeInsets.only(top: 18.0 + bottomPadding),
            labelText: 'Name'),
        ListPicker(
          this._controllers[4],
          margin: EdgeInsets.only(top: 8.0),
          labelText: 'University',
          list: ['Georgia Tech'], // TODO: get from PB
        ),
        ListPicker(
          this._controllers[5],
          margin: EdgeInsets.only(top: 8.0),
          labelText: 'Entrance Year',
          list: List.generate(10, (y) => 2021 - y),
        ),
        Input(
            controller: this._controllers[6],
            margin: EdgeInsets.only(top: 8.0),
            labelText: 'Email')
      ],
      onTapEnter: this.onSignUp,
    );
  }

  Future<bool> onSignUp() async {
    String id = this._controllers[0].text;
    String pw = this._controllers[1].text;
    String rePw = this._controllers[2].text;
    String name = this._controllers[3].text;
    String univName = this._controllers[4].text;
    int entranceYear = int.tryParse(this._controllers[5].text);
    String email = this._controllers[6].text;

    // TODO: validation check
    if ((entranceYear) == null || (pw != rePw)) return false;

    SignUpResult result =
        await Session.signUpUser(id, pw, name, email, univName, entranceYear);

    // TODO: result feedback
    if (result == SignUpResult.success) return true;
    return false;
  }
}
