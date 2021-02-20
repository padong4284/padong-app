import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class MarkdownSupporter extends StatelessWidget {
  MarkdownSupporter();

  @override
  Widget build(BuildContext context) {
    return FloatingBottomBar(
        child: Container(
      height: 38,
      child: Row(children: [
        TranspButton(
            callback: this.addPhoto,
            buttonSize: ButtonSize.GIANT,
            icon: Icon(Icons.photo_camera_rounded,
                size: 30, color: AppTheme.colors.support)),
        Container(width: 2, color: AppTheme.colors.semiSupport),
        Expanded(
            child: ListView(
                scrollDirection: Axis.horizontal, children: this.supporters()))
      ]),
    ));
  }

  void addPhoto() {}

  void applyH(int scale) {}

  void emphasis(){}

  void blockQuote() {}

  void codeBlock() {}

  List<Widget> supporters() {
    ButtonSize size = ButtonSize.GIANT;
    Map<Function, Widget> buttons = {
      () => this.applyH(1): Text('H1',
          style: AppTheme.getFont(
              fontSize: AppTheme.fontSizes.large, isBold: true)),
      () => this.applyH(2): Text('H2',
          style: AppTheme.getFont(
              fontSize: AppTheme.fontSizes.mlarge, isBold: true)),
      () => this.applyH(3): Text('H3',
          style: TextStyle(
            height: 1.25,
            color: AppTheme.colors.fontPalette[1],
            letterSpacing: 0.025,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          )),
      this.emphasis: Text('emphasis', style: TextStyle(
        color: AppTheme.colors.primary,
        backgroundColor: AppTheme.colors.semiPrimary
      ))
    };
    return buttons
        .map((func, widget) => MapEntry(
            func, TranspButton(buttonSize: size, callback: func, icon: widget)))
        .values
        .toList();
  }
/*
  TextStyle getTextStyle({
    Color color,
    Color backgroundColor,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextBaseline textBaseline,
    double height,
    Locale locale,
    Paint foreground,
    Paint background,
    List<Shadow> shadows,
    List<FontFeature> fontFeatures,
    TextDecoration decoration,
    Color decorationColor,
    TextDecorationStyle decorationStyle,
    double decorationThickness,
    String debugLabel,
    String fontFamily,
    List<String> fontFamilyFallback,
    String package}) {
    return TextStyle(
       color: color,
       backgroundColor: backgroundColor,
       fontSize: fontSize,
       fontWeight,
       fontStyle,
       letterSpacing,
       wordSpacing,
       textBaseline,
       height,
       locale,
       foreground,
       background,
        shadows,
       fontFeatures,
       decoration,
       decorationColor,
       decorationStyle,
       decorationThickness,
       debugLabel,
       fontFamily,
       fontFamilyFallback,
       package: pacakge)
  }*/
}
