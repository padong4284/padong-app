import 'package:flutter/material.dart';
import 'sign_view.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return new SignView(false, "Welcome");
  }
}
