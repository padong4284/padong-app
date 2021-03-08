import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class HorizontalScroller extends StatelessWidget {
  final List<Widget> children;
  final double padding;
  final double height;
  final String moreId;
  final parentLeftPadding;
  final parentRightPadding;

  HorizontalScroller(
      {@required this.children,
      this.height = 220,
      this.parentLeftPadding = AppTheme.horizontalPadding,
      this.parentRightPadding = AppTheme.horizontalPadding,
      this.moreId,
      padding})
      : this.padding = padding ?? 5;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int len = this.children.length;
    return Column(children: [
      Container(
          height: this.height,
          transform:
              Matrix4.translationValues(this.parentRightPadding, 0.0, 0.0),
          child: Container(
            transform:
                Matrix4.translationValues(-this.parentLeftPadding, 0.0, 0.0),
            child: OverflowBox(
                minWidth: width,
                maxWidth: width,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: this
                        .children
                        .map((elm) => Container(
                            padding:
                                (this.children.indexOf(elm) % (len - 1) == 0)
                                    ? EdgeInsets.only(
                                        left: this.children.indexOf(elm) == 0
                                            ? this.parentLeftPadding - 5
                                            : this.padding,
                                        right: this.children.indexOf(elm) == 0
                                            ? this.padding
                                            : this.parentRightPadding,
                                      )
                                    : EdgeInsets.symmetric(
                                        horizontal: this.padding),
                            child: elm))
                        .toList())),
          )),
      this.moreId != null
          ? Padding(padding: const EdgeInsets.only(top: 8), child:Align(
              alignment: Alignment.bottomRight,
              child: TranspButton(
                title: 'More',
                buttonSize: ButtonSize.REGULAR,
                icon: Icon(Icons.arrow_forward_ios,
                    color: AppTheme.colors.primary,
                    size: AppTheme.fontSizes.regular),
                isSuffixICon: true,
                callback: () =>
                    PadongRouter.routeURL('/board?id=${this.moreId}'),
              )))
          : SizedBox.shrink()
    ]);
  }
}
