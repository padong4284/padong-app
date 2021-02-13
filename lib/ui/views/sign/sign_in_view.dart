import 'package:flutter/material.dart';
import 'sign_view.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return new SignView(true, "Welcome\nBack");
  }
}
