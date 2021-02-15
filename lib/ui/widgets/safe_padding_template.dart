import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class SafePaddingTemplate extends StatelessWidget {
  final List<Widget> children;

  const SafePaddingTemplate({this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
      child: Column(children: this.children),
    ));
  }
}
