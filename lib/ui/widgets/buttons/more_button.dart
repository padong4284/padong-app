import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class MoreButton extends StatelessWidget {
  final String url;

  MoreButton(this.url);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Align(
            alignment: Alignment.bottomRight,
            child: TranspButton(
              title: 'More',
              buttonSize: ButtonSize.REGULAR,
              icon: Icon(Icons.arrow_forward_ios,
                  color: AppTheme.colors.primary,
                  size: AppTheme.fontSizes.regular),
              isSuffixICon: true,
              callback: () =>
                  PadongRouter.routeURL(this.url),
            )));
  }
}
