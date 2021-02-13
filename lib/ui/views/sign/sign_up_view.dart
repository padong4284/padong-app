import 'package:flutter/material.dart';
import 'sign_view.dart';
import '../../widgets/input.dart';
import '../../shared/types.dart';

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
        Hero(
            tag: 'inputForm',
            child: Center(
                child: Container(
                    width: 280,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 270.0),
                              height: 38.0,
                              child: Input(
                                  hintText: 'ID', type: InputType.ROUNDED)),
                          Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 38.0,
                              child: Input(
                                  hintText: 'Password',
                                  type: InputType.ROUNDED)),
                          Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 38.0,
                              child: Input(
                                  hintText: 'Repeat Password',
                                  type: InputType.ROUNDED)),
                          Container(
                              margin: EdgeInsets.only(top: 50.0),
                              height: 38.0,
                              child: Input(
                                  hintText: 'Name', type: InputType.ROUNDED)),
                          Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 38.0,
                              child: Input(
                                  hintText: 'University',
                                  type: InputType.ROUNDED)),
                          Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 38.0,
                              child: Input(
                                  hintText: 'Entrance Year',
                                  type: InputType.ROUNDED)),
                          Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 38.0,
                              child: Input(
                                  hintText: 'Email', type: InputType.ROUNDED))
                        ])))));
  }
}
