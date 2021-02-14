import 'package:flutter/material.dart';

class HorizontalScroller extends StatelessWidget {
  final List<Widget> children;
  final double padding;
  final parentLeftPadding;
  final parentRightPadding;

  HorizontalScroller(
      {@required this.children,
      @required this.parentLeftPadding,
      @required this.parentRightPadding,
      padding})
      : this.padding = padding ?? 5;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: 230,
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
                          padding: this.children.indexOf(elm) == 0
                              ? EdgeInsets.only(
                                  left: this.parentLeftPadding,
                                  top: this.padding,
                                  right: this.padding,
                                  bottom: this.padding)
                              : EdgeInsets.all(this.padding),
                          child: elm))
                      .toList())),
        ));
  }
}
