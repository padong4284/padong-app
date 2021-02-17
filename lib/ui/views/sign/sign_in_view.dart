import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/shared/types.dart';
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
                      Container(
                          height: 38.0,
                          child:
                              Input(hintText: 'ID', type: InputType.ROUNDED)),
                      Container(
                          margin: EdgeInsets.only(top: 10.0),
                          height: 38.0,
                          child: Input(
                              hintText: 'Password', type: InputType.ROUNDED))
                    ])))));
  }
}
