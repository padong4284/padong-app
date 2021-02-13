import 'package:flutter/material.dart';
import 'sign_view.dart';
import '../../widgets/input.dart';
import '../../shared/types.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return new SignView(
        true,
        "Welcome\nBack",
        Hero(
            tag: 'inputForm',
            child: Center(
                child: Container(
                    width: 280,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 550.0),
                              height: 38.0,
                              child: Input(
                                  hintText: 'ID', type: InputType.ROUNDED)),
                          Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 38.0,
                              child: Input(
                                  hintText: 'Password',
                                  type: InputType.ROUNDED))
                        ])))));
  }
}
