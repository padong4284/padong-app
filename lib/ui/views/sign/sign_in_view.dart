import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/views/sign/sign_view.dart';

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
        Positioned(
            bottom: 140 + MediaQuery.of(context).padding.bottom,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    width: MediaQuery.of(context).size.width -
                        2 * (AppTheme.horizontalPadding + 30),
                    child: Column(children: [
                      Input(hintText: 'ID'),
                      Input(
                          margin: EdgeInsets.only(top: 10.0),
                          hintText: 'Password')
                    ])))));
  }
}
