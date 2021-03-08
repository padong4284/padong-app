import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:padong/core/services/padong_auth.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/views/sign/sign_view.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _rePwController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _univController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double paddingBottom = MediaQuery
        .of(context)
        .padding
        .bottom;
    return new SignView(
      false,
      "Welcome",
      Positioned(
          bottom: 140 + paddingBottom,
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width -
                      2 * (AppTheme.horizontalPadding + 30),
                  child: Column(children: [
                    Input(
                        controller: _idController,
                        margin: EdgeInsets.only(top: 10.0), hintText: 'ID'),
                    Input(
                        controller: _pwController,
                        margin: EdgeInsets.only(top: 10.0),
                        hintText: 'Password'),
                    Input(
                        controller: _rePwController,
                        margin: EdgeInsets.only(top: 10.0),
                        hintText: 'Repeat Password'),
                    // TODO: check match feedback real-time
                    Input(
                        controller: _nameController,
                        margin: EdgeInsets.only(top: 20.0 + paddingBottom),
                        hintText: 'Name'),
                    ListPicker(this._univController,
                        margin: EdgeInsets.only(top: 10.0),
                        hintText: 'University',
                        list: ['Georgia Tech']),
                    // TODO: get univ list
                    ListPicker(
                      this._yearController,
                      margin: EdgeInsets.only(top: 10.0),
                      hintText: 'Entrance Year',
                      list: List.generate(10, (y) => 2021 - y),
                    ),
                    Input(
                        controller: _emailController,
                        margin: EdgeInsets.only(top: 10.0), hintText: 'Email')
                  ]))))
      ,
      onSignUp: this.SignUp,
    );
  }

  Future<bool> SignUp() async {
    String id = _idController.text;
    String pw = _pwController.text;
    String rePw = _rePwController.text;
    String name = _nameController.text;
    String email = _emailController.text;
    String univName = _univController.text;
    int entranceYear = int.tryParse(_yearController.text, radix: 10) ?? 0;
    if (entranceYear == 0) {
      return false;
    }

    if (pw != rePw) {
      return false;
    }

    log("asdf");
    RegistrationReturns ret = await PadongAuth.signUp(
        id, pw, name, email, univName, entranceYear);
    log(ret.index.toString());
    if (ret == RegistrationReturns.success) {
      return true;
    }
    //String univer
    return false;
  }
}
