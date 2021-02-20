import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class MarkdownTheme {
  static TextStyle p = getTextStyle();
  static TextStyle a = getTextStyle(color: AppTheme.colors.primary);
  static TextStyle h1 =
      getTextStyle(fontSize: AppTheme.fontSizes.xlarge, isBold: true);
  static TextStyle h2 =
      getTextStyle(fontSize: AppTheme.fontSizes.large, isBold: true);
  static TextStyle h3 = getTextStyle(
      fontSize: AppTheme.fontSizes.mlarge, isBold: true, isUnderline: true);

  static TextStyle strong = getTextStyle(
      color: AppTheme.colors.primary,
      backgroundColor: AppTheme.colors.semiPrimary);
  static TextStyle em = getTextStyle(isItalic: true);

  static TextStyle blockQuote =
      getTextStyle(color: AppTheme.colors.fontPalette[1]);
  static TextStyle codeBlock = TextStyle(
      fontSize: AppTheme.fontSizes.regular,
      fontFamily: "monospace",
      color: AppTheme.colors.fontPalette[4],
      backgroundColor: Color(0xFF202326));

  static Decoration horizontalRule = BoxDecoration(
      border: Border(
          top: BorderSide(
    color: AppTheme.colors.semiSupport,
    width: 1.5,
  )));
}
