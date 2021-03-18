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
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/highlight.dart' show highlight, Node;
import 'package:flutter/painting.dart';
import 'package:padong/ui/theme/markdown_theme.dart';

class PadongSyntaxHighlighter extends SyntaxHighlighter {
  final String language;
  final _rootKey = 'root';
  final _defaultFontFamily = 'monospace';
  final _defaultFontColor = Color(0xfffdfeff);
  final Map<String, TextStyle> theme = CodeTheme;

  PadongSyntaxHighlighter({this.language = 'python'});

  @override
  TextSpan format(String source) {
    String lang;
    if (source.startsWith('!L@NG{[')) {
      int idx = source.indexOf(']}L@NG!');
      lang = source.substring(7, idx);
      source = source.substring(idx + 8);
    }
    source += '\n' + ' ' * 82;
    var _textStyle = TextStyle(
      fontFamily: this._defaultFontFamily,
      color: this.theme[this._rootKey].color ?? this._defaultFontColor,
    );
    return TextSpan(
      style: _textStyle,
      children: _convert(highlight
          .parse(source, autoDetection: true, language: lang ?? this.language)
          .nodes),
    );
  }

  List<TextSpan> _convert(List<Node> nodes) {
    List<TextSpan> spans = [];
    var currentSpans = spans;
    List<List<TextSpan>> stack = [];

    _traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(node.className == null
            ? TextSpan(text: node.value)
            : TextSpan(text: node.value, style: theme[node.className]));
      } else if (node.children != null) {
        List<TextSpan> tmp = [];
        currentSpans.add(TextSpan(children: tmp, style: theme[node.className]));
        stack.add(currentSpans);
        currentSpans = tmp;

        node.children.forEach((n) {
          _traverse(n);
          if (n == node.children.last)
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
        });
      }
    }

    for (var node in nodes) _traverse(node);
    return spans;
  }
}

