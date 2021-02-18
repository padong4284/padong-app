import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final List<Widget> buttons;
  final bool isClose;

  BackAppBar(
      {Key key, this.title, this.buttons, this.isClose = false})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      // when dark mode, using dark
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: this.title != null
          ? Text(this.title,
              textAlign: TextAlign.center,
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[0],
                  fontSize: AppTheme.fontSizes.large))
          : null,
      centerTitle: true,
      leading: Padding(
          padding: EdgeInsets.only(left: AppTheme.horizontalPadding),
          child: TranspButton(
              buttonSize: ButtonSize.LARGE,
              callback: () {Navigator.pop(context);},
              icon: Icon(
                  this.isClose ? Icons.close : Icons.arrow_back_ios_rounded,
                  size: 25))),
      leadingWidth: 25 + AppTheme.horizontalPadding,
      actions: [
        ...buttons.map((button) => SizedBox(
            width: 32.0,
            child: button)),
        SizedBox(width: AppTheme.horizontalPadding)
      ],
    );
  }
}
