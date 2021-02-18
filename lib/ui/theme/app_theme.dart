import 'package:flutter/material.dart';
import 'colors.dart';
import 'font_sizes.dart';

class AppTheme {
  static const colors = AppColors();
  static const fontSizes = FontSizes();
  static const horizontalPadding = 25.0;

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

  static TextStyle getFont({@required color, fontSize, isBold = false}) {
    return TextStyle(
        height: 1.25,
        color: color,
        letterSpacing: 0.025,
        decoration: TextDecoration.none,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize ?? AppTheme.fontSizes.regular);
  }
}

Widget heroFlightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) { // set Text Theme while hero animation
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}
