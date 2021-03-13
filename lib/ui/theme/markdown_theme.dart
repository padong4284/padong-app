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
import 'package:padong/util/padong_syntax_hightlighter.dart';

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

const CodeTheme = {
  'root': TextStyle(
      backgroundColor: Color(0xff202326), color: Color(0xfffdfeff)), //
  'comment': TextStyle(color: Color(0xff669955)), //
  'quote': TextStyle(color: Color(0xff007400)),
  'tag': TextStyle(color: Color(0xff8fcfdf)), //
  'selector-tag': TextStyle(color: Color(0xff8fcfdf)), //
  'attribute': TextStyle(color: Color(0xff4ec9b0)),
  'keyword': TextStyle(color: Color(0xff05b0ea)), //
  'literal': TextStyle(color: Color(0xffff6600)), // True
  'name': TextStyle(color: Color(0xffff6600)),
  'variable': TextStyle(color: Color(0xff9cdcfe)), //
  'template-variable': TextStyle(color: Color(0xff3F6E74)),
  'code': TextStyle(color: Color(0xfff51525)),
  'string': TextStyle(color: Color(0xffff9900)), //
  'meta-string': TextStyle(color: Color(0xffff5353)),
  'regexp': TextStyle(color: Color(0xff10c0e0)),
  'link': TextStyle(color: Color(0xff8fcfdf)),
  'title': TextStyle(color: Color(0xfff0d070)), //
  'symbol': TextStyle(color: Color(0xffb5cea8)), //
  'bullet': TextStyle(color: Color(0xff059acb)),
  'number': TextStyle(color: Color(0xffff5353)), //
  'section': TextStyle(color: Color(0xfff51525)),
  'meta': TextStyle(color: Color(0xfff51525)),
  'type': TextStyle(color: Color(0xff4ec9b0)),
  'built_in': TextStyle(color: Color(0xff05b0ea)), //
  'builtin-name': TextStyle(color: Color(0xff059acb)),
  'params': TextStyle(color: Color(0xff9cdcfe)), //
  'attr': TextStyle(color: Color(0xff10c0e0)),
  'subst': TextStyle(color: Color(0xffff6600)), //
  'formula': TextStyle(
      backgroundColor: Color(0xffff6600), fontStyle: FontStyle.italic),
  'addition': TextStyle(backgroundColor: Color(0xff9cdcfe)),
  'deletion': TextStyle(backgroundColor: Color(0xfff0d070)),
  'selector-id': TextStyle(color: Color(0xffff9900)),
  'selector-class': TextStyle(color: Color(0xfff0d070)),
  'doctag': TextStyle(fontWeight: FontWeight.bold),
  'strong': TextStyle(fontWeight: FontWeight.bold),
  'emphasis': TextStyle(fontStyle: FontStyle.italic),
};