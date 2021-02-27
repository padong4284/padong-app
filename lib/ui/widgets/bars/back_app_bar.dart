import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final List<Widget> actions;
  final SwitchButton switchButton;
  final bool isClose;

  BackAppBar({Key key, title, switchButton, this.actions, this.isClose = false})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        assert(title == null || switchButton == null),
        this.title = title,
        this.switchButton = switchButton,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      // when dark mode, using dark
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: this.switchButton != null
          ? this.switchButton
          : this.title != null
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
              callback: () {
                PadongRouter.goBack();
              },
              icon: Icon(
                  this.isClose ? Icons.close : Icons.arrow_back_ios_rounded,
                  size: 25))),
      leadingWidth: 25 + AppTheme.horizontalPadding,
      actions: [
        ...(this.actions ?? []).map((button) => Container(
            alignment: Alignment.centerRight,
            child: SizedBox(width: button is Button ? 67 : 32, child: button))),
        SizedBox(width: AppTheme.horizontalPadding)
      ],
    );
  }
}
