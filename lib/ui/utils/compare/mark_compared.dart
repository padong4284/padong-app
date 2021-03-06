import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/compare/diff_line.dart';

class MarkCompared extends StatelessWidget {
  final String prev;
  final String next;

  MarkCompared(this.prev, this.next);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: AppTheme.getFont(),
            children: this.getCompared(this.prev, this.next)));
  }

  List<TextSpan> getCompared(String prev, String next) {
    List<TextSpan> compared = [];
    List<Diff> diffs = diffLine(prev, next);
    for (Diff diff in diffs) {
      if (diff.op == EQUAL)
        compared.add(TextSpan(text: diff.text));
      else {
        compared.add(TextSpan(
            text: diff.text,
            style: getTextStyle(
                color: AppTheme.colors.fontPalette[diff.op == DELETE ? 2 : 0],
                backgroundColor: diff.op == DELETE
                    ? AppTheme.colors.pointRed.withAlpha(70)
                    : AppTheme.colors.primary
                        .withAlpha(70)))); // diff.op == INSERT
      }
    }
    return compared;
  }
}
