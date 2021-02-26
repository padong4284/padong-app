import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class TitleHeader extends StatelessWidget {
  final String title;
  final String link;
  final Function moreCallback;
  final bool isInputHead;

  // link -> BIG with link
  // moreCallback -> Horizontal more
  // isInputHead -> input head
  // no option -> vertical without more
  TitleHeader(this.title, {link, moreCallback, this.isInputHead = false})
      : assert((link == null) || (moreCallback == null)),
        this.link = link,
        this.moreCallback = moreCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        this.link != null ? SizedBox(height: 12) : SizedBox.shrink(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            this.title,
            style: AppTheme.getFont(
                color: this.link != null
                    ? AppTheme.colors.fontPalette[1]
                    : AppTheme.colors.fontPalette[2],
                fontSize: this.link != null
                    ? AppTheme.fontSizes.xlarge
                    : AppTheme.fontSizes.mlarge,
                isBold: true),
          ),
          this.getRightButton()
        ]),
        Container(
            height: 2,
            margin: EdgeInsets.only(
                top: this.link != null ? 8 : 3,
                bottom: this.link != null ? 14 : 3),
            alignment: Alignment.bottomLeft,
            color: this.isInputHead
                ? AppTheme.colors.lightSupport
                : AppTheme.colors.semiSupport)
      ],
    );
  }

  Widget getRightButton() {
    return this.moreCallback != null
        ? TranspButton(
            title: 'More',
            callback: this.moreCallback,
            buttonSize: ButtonSize.SMALL,
            color: AppTheme.colors.primary,
            icon: Icon(Icons.arrow_forward_ios_rounded,
                color: AppTheme.colors.primary, size: 15.0),
            isSuffixICon: true,
          )
        : this.link != null
            ? TranspButton(
                icon: Icon(Icons.link_rounded, size: 25),
                buttonSize: ButtonSize.LARGE,
                callback: () {
                  if (this.link.length > 0)
                    PadongRouter.routeURL(this.link);
                }) // TODO: Route to link
            : SizedBox.shrink();
  }
}
