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
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/shared/validator.dart';
import 'package:padong/ui/view/sign/base_sign_view.dart';
import 'package:padong/ui/widget/input/input.dart';
import 'package:padong/ui/widget/input/list_picker.dart';
import 'package:padong/ui/widget/dialog/terms_dialog.dart';

const String WAIT_MSG = 'Please Wait..';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  List<String> universityList = [WAIT_MSG];
  final List<String> _labels = [
    'ID',
    'Password',
    'Repeat Password',
    'Name',
    'University',
    'Entrance Year',
    'Email'
  ];
  List<String> _errorTexts = List.generate(7, (_) => null);
  final List<TextEditingController> _controllers =
      List.generate(7, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    University.getUnivList().then((univs) => setState(() {
          univs.sort();
          this.universityList = univs;
        }));
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return BaseSignView(
      isSignIn: false,
      welcomeMsg: "Welcome",
      idErrorText: this._errorTexts[0],
      idController: this._controllers[0],
      onIdChanged: (_) => this._setErrorText(),
      forms: [
        Input(
            isPrivacy: true,
            controller: this._controllers[1],
            margin: EdgeInsets.only(top: 8.0),
            labelText: this._labels[1],
            errorText: this._errorTexts[1],
            onChanged: (_) {
              this._controllers[2].text = '';
              this._initError(_);
            }),
        Input(
            isPrivacy: true,
            controller: this._controllers[2],
            margin: EdgeInsets.only(top: 8.0),
            labelText: this._labels[2],
            errorText: this._errorTexts[2],
            onChanged: (repeat) => setState(() => this._errorTexts[2] =
                !this._controllers[1].text.startsWith(repeat)
                    ? "Repeat Password doesn't match"
                    : null)),
        Input(
            controller: this._controllers[3],
            margin: EdgeInsets.only(top: 18.0 + bottomPadding),
            labelText: this._labels[3],
            errorText: this._errorTexts[3],
            onChanged: this._initError),
        ListPicker(
          this._controllers[4],
          margin: EdgeInsets.only(top: 8.0),
          labelText: this._labels[4],
          list: this.universityList,
          errorText: this._errorTexts[4],
        ),
        ListPicker(
          this._controllers[5],
          margin: EdgeInsets.only(top: 8.0),
          labelText: this._labels[5],
          list: List.generate(10, (y) => 2021 - y),
          errorText: this._errorTexts[5],
        ),
        Input(
          controller: this._controllers[6],
          margin: EdgeInsets.only(top: 8.0),
          labelText: this._labels[6],
          errorText: this._errorTexts[6],
          onChanged: (e){
            _setErrorText();
          },
        )
      ],
      onTapEnter: () async {
        if (await TermsDialog.show(context)) return this.onSignUp();
        return false;
      },
    );
  }

  void _initError(String curr) {
    if (curr.isEmpty) this._setErrorText();
  }

  bool _setErrorText([int idx, String errorText]) {
    setState(() {
      this._errorTexts = List.generate(7, (_) => null);
      if (idx != null) this._errorTexts[idx] = errorText;
    });
    return false;
  }

  Future<bool> onSignUp() async {
    // empty check
    if (this._controllers[4].text == WAIT_MSG) return false;
    for (var i = 0; i < this._controllers.length; i++)
      if (this._controllers[i].text.isEmpty)
        return this._setErrorText(i, "${this._labels[i]} is empty");

    String id = this._controllers[0].text;
    String pw = this._controllers[1].text;
    String rePw = this._controllers[2].text;
    String name = this._controllers[3].text;
    String univName = this._controllers[4].text;
    int entranceYear = int.tryParse(this._controllers[5].text);
    String email = this._controllers[6].text;

    // Google ID rule : 6~30 lower alphabet, number and '.'
    if (id.length < 6 || id.length > 30)
      return this._setErrorText(0, "The length of ID is 6~30.");
    if (!Validator.isValid(Validator.idRule, id))
      return this
          ._setErrorText(0, "Use only lowercase alphabet, number and '.'");

    if (pw != rePw) // with real-time matching
      return this._setErrorText(2, "Repeat Password doesn't match");
    if (!Validator.isValidPW(pw, this._setErrorText)) return false;

    if (!Validator.isValid(Validator.emailRule, email))
      return this._setErrorText(6, 'Pleas Check An Email.');


    SignUpResult result =
        await Session.signUpUser(id, pw, name, email, univName, entranceYear);
    if (result == SignUpResult.success) {
      for (TextEditingController controller in this._controllers)
        controller.text = '';
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please check email for verification ($email)')));
      return true;
    } else if(result == SignUpResult.InvalidUniversityEmail){
      return this._setErrorText(6, "Wrong University Email Address");
    }

    List codes = {
      SignUpResult.IdAlreadyInUse: [0, "ID already in used"],
      SignUpResult.WeakPassword: [1, "Password is too weak."],
      SignUpResult.EmailAlreadyInUse: [6, "Email already in used"],
      SignUpResult.UniversityNotFound: [4, "University not found"],
    }[result];
    if (codes != null) return this._setErrorText(codes[0], codes[1]);
    return this._setErrorText(0, "Sorry, failed Sign Up");
  }
}
