///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///*
///* Github [https://github.com/padong4284]
///*********************************************************************
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/theme/padong_syntax_hightlighter.dart';

class MarkdownTheme {
  static TextStyle p = getTextStyle(color: AppTheme.colors.fontPalette[2]);
  static TextStyle a = getTextStyle(color: AppTheme.colors.primary);
  static TextStyle h1 =
      getTextStyle(fontSize: AppTheme.fontSizes.large, isBold: true);
  static TextStyle h2 =
      getTextStyle(fontSize: AppTheme.fontSizes.mlarge, isBold: true);
  static TextStyle h3 = getTextStyle(isBold: true);

  static TextStyle strong =
      getTextStyle(isBold: true, backgroundColor: Color(0xB174D2E3));
  static TextStyle italic = getTextStyle(isItalic: true);
  static TextStyle del = getTextStyle(isLineThrough: true);

  static TextStyle blockQuote =
      getTextStyle(color: AppTheme.colors.fontPalette[1]);
  static TextStyle inlineCode = TextStyle(
      fontFamily: "monospace",
      fontSize: AppTheme.fontSizes.regular,
      color: AppTheme.colors.primary,
      backgroundColor: AppTheme.colors.semiPrimary);

  static Decoration horizontalRule = BoxDecoration(
      border: Border(
          top: BorderSide(
    color: AppTheme.colors.semiSupport,
    width: 1.5,
  )));

  static SyntaxHighlighter syntaxHighlighter = PadongSyntaxHighlighter();
}
