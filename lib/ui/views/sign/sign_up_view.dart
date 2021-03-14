import 'dart:developer';

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
import 'package:padong/core/shared/validator.dart' as validator;
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/views/sign/sign_view.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  List<String> errorText = List.generate(7, (_) => null);
  final List<TextEditingController> _controllers =
      List.generate(7, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    return new SignView(
      false,
      "Welcome",
      Positioned(
          bottom: 140 + paddingBottom,
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: ListBuilder(paddingBottom))),
      this.onSignUp,
    );
  }

  Widget ListBuilder(double paddingBottom) {
    return ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.purple],
            stops: [0.9, 1.0], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: Container(
            height: MediaQuery.of(context).size.height / 2,
            child: SingleChildScrollView(child: TextFields(paddingBottom))));
  }

  Widget TextFields(double paddingBottom) {
    return Container(
        width: MediaQuery.of(context).size.width -
            2 * (AppTheme.horizontalPadding + 30),
        child: Column(children: [
          Input(
              errorText: this.errorText[0],
              controller: this._controllers[0],
              margin: EdgeInsets.only(top: 10.0),
              hintText: 'ID'),
          Input(
              errorText: this.errorText[1],
              controller: this._controllers[1],
              margin: EdgeInsets.only(top: 10.0),
              obsecure: true,
              hintText: 'Password'),
          Input(
              errorText: this.errorText[2],
              controller: this._controllers[2],
              margin: EdgeInsets.only(top: 10.0),
              obsecure: true,
              hintText: 'Repeat Password'),
          // TODO: check match feedback real-time
          Input(
              errorText: this.errorText[3],
              controller: this._controllers[3],
              margin: EdgeInsets.only(top: 20.0 + paddingBottom),
              hintText: 'Name'),
          ListPicker(
            this._controllers[4],
            errorText: this.errorText[4],
            margin: EdgeInsets.only(top: 10.0),
            hintText: 'University',
            list: ['Georgia Tech'], // TODO: get from PB
          ),
          // TODO: get univ list
          ListPicker(
            this._controllers[5],
            errorText: this.errorText[5],
            margin: EdgeInsets.only(top: 10.0),
            hintText: 'Entrance Year',
            list: List.generate(10, (y) => 2021 - y),
          ),
          Input(
              errorText: this.errorText[6],
              controller: this._controllers[6],
              margin: EdgeInsets.only(top: 10.0),
              hintText: 'Email')
        ]));
  }

  _resetBorderColors() {
    this.errorText = List.generate(7, (_) => null);
  }

  bool validateEmptyInputs() {
    for (var i = 0; i < this._controllers.length; i++) {
      if (this._controllers[i].text == "") {
        _setErrorMessage(i, "empty value");
        return true;
      }
    }

    return false;
  }

  _setErrorMessage(int index, String message) {
    setState(() {
      this.errorText[index] = message;
    });
  }

  //구글 아이디 생성 규칙 : 6~30자의 영문 소문자, 숫자와 특수기호(.)만 사용 가능합니다.
  bool validateId(String id) {
    if (!validator.isValid(validator.idRule, id)) {
      _setErrorMessage(0,
          "Id is not valid. Can only use 6~30 letters of lowercase alphabet, number and special charactor(.)");
      return true;
    }
    return false;
  }

  // 구글 비밀번호 생성 규칙 : 비밀번호 8자리 이상, 문자, 특수문자, 숫자 조합.
  bool validatePw(String pw, String rePw) {
    RegExp specialChar = new RegExp(r"\W");
    RegExp alphabetChar = new RegExp(r"[a-zA-Z]");
    RegExp numberChar = new RegExp(r"[0-9]");

    if (pw != rePw) {
      _setErrorMessage(2, "passwords are not equal");
      return true;
    }

    if (pw.length < 6) {
      _setErrorMessage(2, "password's length at least 6");
      return true;
    }
    if (!(specialChar.hasMatch(pw) &&
        alphabetChar.hasMatch(pw) &&
        numberChar.hasMatch(pw))) {
      _setErrorMessage(2,
          "password must contain at least 8 characters including special charactor, alphabet and number");
      return true;
    }

    return false;
  }

  bool validateEntranceYear(int entranceYear) {
    if (entranceYear <= 0) {
      _setErrorMessage(5, "EntranceYear doesn't valid");
      return true;
    }
    return false;
  }

  bool validateEmail(String email) {
    if (!validator.isValid(validator.emailRule, email)) {
      _setErrorMessage(6, "email doesn't valid");
      return true;
    }
    return false;
  }

  //return success of validate value
  validateInputs(String userId, String pw, String rePw, String name,
      String email, String universityName, int entranceYear) {
    return validateEmptyInputs() ||
        validateId(userId) ||
        validatePw(pw, rePw) ||
        validateEntranceYear(entranceYear) ||
        validateEmail(email);
  }

  Future<bool> onSignUp() async {
    String id = this._controllers[0].text;
    String pw = this._controllers[1].text;
    String rePw = this._controllers[2].text;
    String name = this._controllers[3].text;
    String univName = this._controllers[4].text;
    int entranceYear = int.tryParse(this._controllers[5].text);
    String email = this._controllers[6].text;

    _resetBorderColors();
    if (validateInputs(id, pw, rePw, name, email, univName, entranceYear)) {
      return false;
    }

    SignUpResult result;
    //try{
      result =
          await Session.signUpUser(id, pw, name, email, univName, entranceYear);
    /*} catch (e){
      log(e.toString());
      return false;
    }*/

    if (result == SignUpResult.weak_password) {
      _setErrorMessage(2, "");
    }
    if (result == SignUpResult.success) return true;

    if (result == SignUpResult.IdAlreadyInUse) {
      _setErrorMessage(0, "Id already in used");
      return false;
    } else if (result == SignUpResult.emailAlreadyInUse) {
      _setErrorMessage(6, "Email already in used");
      return false;
    } else if (result == SignUpResult.UniversityNotFound) {
      _setErrorMessage(4, "University not found");
      return false;
    }
    _setErrorMessage(0, "SignUp Failed");
    return false;
  }
}
