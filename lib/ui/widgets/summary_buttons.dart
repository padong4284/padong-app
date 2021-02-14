import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/transp_button.dart';

List<IconData> unclickeds = [
  Icons.favorite_border_rounded,
  Icons.mode_comment_outlined,
  Icons.bookmark_border_rounded
];
List<IconData> clickeds = [
  Icons.favorite_rounded,
  Icons.mode_comment,
  Icons.bookmark_rounded
];
List<Color> clickedClrs = [
  AppTheme.colors.pointRed,
  AppTheme.colors.primary,
  AppTheme.colors.pointYellow
];

class SummaryButtons extends StatefulWidget {
  final double left;
  final double gap;
  final Color color;
  final bool isTwo;
  final dynamic summary; // [likes, replies, bookmarks], if null: don't show

  SummaryButtons({this.left = -10, this.gap = 47, color, @required summary})
      : this.color = color ?? AppTheme.colors.support,
        this.summary = summary,
        this.isTwo = summary.contains(null);

  @override
  _SummaryButtonsState createState() => _SummaryButtonsState();
}

class _SummaryButtonsState extends State<SummaryButtons> {
  List<bool> isClickeds = [false, false, false]; // likes, replies, bookmarks
  IconData getIcon(int idx) {
    if (this.isClickeds[idx]) return clickeds[idx];
    return unclickeds[idx];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(width: 500, height: 30),
      ...[0, 1, 2]
          .map((idx) => widget.summary[idx] == null
              ? null
              : Positioned(
                  left: widget.left + widget.gap * this.getGapIdx(idx),
                  bottom: 0,
                  child: TranspButton(
                      buttonSize: ButtonSize.REGULAR,
                      callback: () => {
                            setState(() {
                              this.isClickeds[idx] = !this.isClickeds[idx];
                            })
                          },
                      icon: Icon(
                        this.getIcon(idx),
                        color: this.isClickeds[idx]
                            ? clickedClrs[idx]
                            : AppTheme.colors.support,
                        size: 16.0,
                      ))))
          .where((element) => element != null),
      ...[0, 1, 2]
          .map((idx) => widget.summary[idx] == null
              ? null
              : Positioned(
                  left: widget.left + 33 + widget.gap * this.getGapIdx(idx),
                  bottom: 1,
                  child: getNumText(idx)))
          .where((element) => element != null)
    ]);
  }

  Text getNumText(idx) {
    return Text(widget.summary[idx].toString(),
        style: TextStyle(
            color: this.isClickeds[idx] ? clickedClrs[idx] : widget.color,
            fontSize: AppTheme.fontSizes.regular));
  }

  int getGapIdx(idx) {
    return widget.isTwo
        ? idx > 0
            ? 1
            : 0
        : idx;
  }
}
