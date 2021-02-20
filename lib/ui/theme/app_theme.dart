import 'package:flutter/material.dart';
import 'package:padong/ui/theme/colors.dart';
import 'package:padong/ui/theme/font_sizes.dart';

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

  static TextStyle getFont({color, fontSize, isBold = false}) {
    return TextStyle(
        height: 1.25,
        color: color ?? AppTheme.colors.fontPalette[1],
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
) {
  // set Text Theme while hero animation
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}

TextStyle getTextStyle({
  Color color,
  Color backgroundColor,
  double fontSize,
  bool isBold = false,
  bool isItalic = false,
  bool isUnderline = false,
  bool isLineThrough = false,
}) {
  assert(!isUnderline || !isLineThrough);
  return TextStyle(
    height: 1.25,
    letterSpacing: 0.25,
    decorationThickness: 2.0,
    color: color ?? AppTheme.colors.fontPalette[1],
    backgroundColor: backgroundColor,
    fontSize: fontSize ?? AppTheme.fontSizes.regular,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    decoration: isUnderline
        ? TextDecoration.underline
        : (isLineThrough ? TextDecoration.lineThrough : TextDecoration.none),
    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
  );
}
