import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class HorizontalScroller extends StatelessWidget {
  final List<Widget> children;
  final double padding;
  final parentLeftPadding;
  final parentRightPadding;

  HorizontalScroller(
      {@required this.children,
      this.parentLeftPadding = AppTheme.horizontalPadding,
      this.parentRightPadding = AppTheme.horizontalPadding,
      padding})
      : this.padding = padding ?? 5;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int len = this.children.length;
    return Container(
        height: 220,
        transform: Matrix4.translationValues(this.parentRightPadding, 0.0, 0.0),
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
                          padding: (this.children.indexOf(elm) % (len - 1) == 0)
                              ? EdgeInsets.only(
                                  left: this.children.indexOf(elm) == 0
                                      ? this.parentLeftPadding - 5
                                      : this.padding,
                                  right: this.children.indexOf(elm) == 0
                                      ? this.padding
                                      : this.parentRightPadding,
                                )
                              : EdgeInsets.symmetric(horizontal: this.padding),
                          child: elm))
                      .toList())),
        ));
  }
}
