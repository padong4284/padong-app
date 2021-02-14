import 'package:flutter/material.dart';

class SafePaddingTemplate extends StatelessWidget {
  final Widget child;

  const SafePaddingTemplate({this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: (this.child),
    ));
  }
}
