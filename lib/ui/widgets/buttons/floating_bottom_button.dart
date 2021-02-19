import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/button.dart';

class FloatingBottomButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isScrollingDown;

  FloatingBottomButton(
      {@required this.title,
      @required this.onTap,
      this.isScrollingDown = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: this.isScrollingDown ? 0.0 : 1.0,
        duration: Duration(milliseconds: 500),
        child: Container(
            width: 100,
            color: AppTheme.colors.transparent,
            margin: const EdgeInsets.only(bottom: 15),
            child: Button(
                title: this.title,
                buttonSize: ButtonSize.REGULAR,
                color: AppTheme.colors.support,
              callback: this.isScrollingDown ? null : this.onTap,
                icon: Container(
                    transform: Matrix4.translationValues(-6.0, 0.0, 0.0),
                    child: Icon(Icons.create_rounded,
                        size: 14, color: AppTheme.colors.base)))));
  }
}
