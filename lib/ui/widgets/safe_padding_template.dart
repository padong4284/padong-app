import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class SafePaddingTemplate extends StatelessWidget {
  final Widget child;

  const SafePaddingTemplate({this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
      child: this.child,
    ));
  }
}
