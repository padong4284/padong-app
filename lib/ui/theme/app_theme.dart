import 'package:flutter/material.dart';
import 'colors.dart';
import 'font_sizes.dart';

class AppTheme {
  static const colors = AppColors();
  static const fontSizes = FontSizes();
  const AppTheme._();

  static ThemeData define() {
    return ThemeData(
      fontFamily: "NotoSans",
      primaryColor: colors.primary,
      accentColor: colors.semiPrimary,
      focusColor: colors.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static TextStyle getFont({@required color, @required fontSize, isBold=false}) {
    return TextStyle(
        height: 1.25,
        color: color,
        letterSpacing: 0.025,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize);
  }
}