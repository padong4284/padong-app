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
        Positioned(
            bottom: 174,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    width: 280,
                    child: Column(
                        children: [
                          Container(
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
