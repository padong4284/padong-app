import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static const colors = AppColors();
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