import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class SafePaddingTemplate extends StatelessWidget {
  final String title;
  final AppBar appBar;
  final List<Widget> children;

  const SafePaddingTemplate(
      {this.appBar, @required this.children, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: this.appBar,
        body: SafeArea(
            child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                this.title.length > 0 ? this._topTitle() : null,
                ...this.children
              ].where((elm) => elm != null).toList()),
        )));
  }

  Widget _topTitle() {
    return Container(
        height: AppBar().preferredSize.height,
        alignment: Alignment.centerLeft,
        child: Text(this.title,
            style: AppTheme.getFont(
                fontSize: AppTheme.fontSizes.large,
                color: AppTheme.colors.semiPrimary)));
  }
}
