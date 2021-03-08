import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';

class BottomButtons extends StatefulWidget {
  final double left;
  final double gap;
  final Color color;
  final bool isTwo;
  final dynamic bottoms; // [likes, replies, bookmarks], if null: don't show

  BottomButtons({this.left = 0, this.gap = 40, color, @required bottoms})
      : this.color = color ?? AppTheme.colors.support,
        this.bottoms = bottoms,
        this.isTwo = bottoms.contains(null);

  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  List<bool> isClickeds = [false, false, false]; // likes, replies, bookmarks

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(width: 500, height: 30),
      ...[0, 1, 2]
          .map((idx) => widget.bottoms[idx] == null
              ? null
              : Positioned(
                  left: widget.left + widget.gap * this.getGapIdx(idx),
                  bottom: 2,
                  child: ToggleIconButton(
                    defaultIcon: unclickeds[idx],
                    toggleIcon: clickeds[idx],
                    size: 16,
                    defaultColor: AppTheme.colors.support,
                    toggleColor: clickedClrs[idx],
                    isToggled: this.isClickeds[idx],
                    alignment: Alignment.bottomCenter,
                  )))
          .where((element) => element != null),
      ...[0, 1, 2]
          .map((idx) => widget.bottoms[idx] == null
              ? null
              : Positioned(
                  left: widget.left + 20 + widget.gap * this.getGapIdx(idx),
                  bottom: 1,
                  child: getNumText(idx)))
          .where((element) => element != null)
    ]);
  }

  Text getNumText(idx) {
    return Text(widget.bottoms[idx].toString(),
        style: TextStyle(
            color: this.isClickeds[idx] ? clickedClrs[idx] : widget.color,
            fontSize: AppTheme.fontSizes.regular));
  }

  int getGapIdx(idx) {
    return widget.isTwo
        ? idx > 0 ? 1 : 0
        : idx;
  }
}


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
