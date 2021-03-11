import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class MoreButton extends StatelessWidget {
  final String url;
  final bool expanded;
  final Function() expandFunction;

  MoreButton(this.url, {this.expanded, this.expandFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Align(
            alignment: Alignment.bottomRight,
            child: TranspButton(
              title: 'More',
              buttonSize: ButtonSize.REGULAR,
              icon: Icon(
                  this.expanded == null
                      ? Icons.arrow_forward_ios
                      : this.expanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                  color: AppTheme.colors.primary,
                  size:
                      this.expanded == null ? AppTheme.fontSizes.regular : 20),
              isSuffixICon: true,
              callback: this.expanded == null
                  ? () => PadongRouter.routeURL(this.url)
                  : this.expandFunction, // nothing
            )));
  }
}
