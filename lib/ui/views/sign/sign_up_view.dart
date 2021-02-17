import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/views/sign/sign_view.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return new SignView(
        false,
        "Welcome",
        Positioned(
            bottom: 140 + MediaQuery.of(context).padding.bottom,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    width: MediaQuery.of(context).size.width -
                        2 * (AppTheme.horizontalPadding + 30),
                    child: Column(children: [
                      Container(
                          margin: EdgeInsets.only(top: 270.0),
                          height: 38.0,
                          child:
                              Input(hintText: 'ID', type: InputType.ROUNDED)),
                      Container(
                          margin: EdgeInsets.only(top: 10.0),
                          height: 38.0,
                          child: Input(
                              hintText: 'Password', type: InputType.ROUNDED)),
                      Container(
                          margin: EdgeInsets.only(top: 10.0),
                          height: 38.0,
                          child: Input(
                              hintText: 'Repeat Password',
                              type: InputType.ROUNDED)),
                      Container(
                          margin: EdgeInsets.only(
                              top:
                                  20.0 + MediaQuery.of(context).padding.bottom),
                          height: 38.0,
                          child:
                              Input(hintText: 'Name', type: InputType.ROUNDED)),
                      Container(
                          margin: EdgeInsets.only(top: 10.0),
                          height: 38.0,
                          child: Input(
                              hintText: 'University', type: InputType.ROUNDED)),
                      Container(
                          margin: EdgeInsets.only(top: 10.0),
                          height: 38.0,
                          child: Input(
                              hintText: 'Entrance Year',
                              type: InputType.ROUNDED)),
                      Container(
                          margin: EdgeInsets.only(top: 10.0),
                          height: 38.0,
                          child:
                              Input(hintText: 'Email', type: InputType.ROUNDED))
                    ])))));
  }
}
