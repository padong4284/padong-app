import 'package:flutter/material.dart';

class LeftRightPaddingContainer extends StatelessWidget {
  final Widget child;

  const LeftRightPaddingContainer({ this.child });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: this.child,
    );
  }
}