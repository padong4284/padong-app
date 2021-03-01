import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/views/sign/sign_view.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController _univController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

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
                child: Container(
                    width: MediaQuery.of(context).size.width -
                        2 * (AppTheme.horizontalPadding + 30),
                    child: Column(children: [
                      Input(margin: EdgeInsets.only(top: 10.0), hintText: 'ID'),
                      Input(
                          margin: EdgeInsets.only(top: 10.0),
                          hintText: 'Password'),
                      Input(
                          margin: EdgeInsets.only(top: 10.0),
                          hintText: 'Repeat Password'),
                      Input(
                          margin: EdgeInsets.only(top: 20.0 + paddingBottom),
                          hintText: 'Name'),
                      ListPicker(this._univController,
                          margin: EdgeInsets.only(top: 10.0),
                          hintText: 'University',
                          list: ['Georgia Tech']),
                      ListPicker(
                        this._yearController,
                        margin: EdgeInsets.only(top: 10.0),
                        hintText: 'Entrance Year',
                        list: List.generate(10, (y) => 2021 - y),
                      ),
                      Input(
                          margin: EdgeInsets.only(top: 10.0), hintText: 'Email')
                    ])))));
  }
}
