import 'package:flutter/material.dart';

class SafePaddingTemplate extends StatelessWidget {
  final Widget child;

  const SafePaddingTemplate({this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: this.child,
    ));
  }
}
