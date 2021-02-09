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
}