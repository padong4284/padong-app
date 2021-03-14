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
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/util/compare/diff_line.dart';

class DiffMarker extends StatelessWidget {
  final String prev;
  final String next;

  DiffMarker(this.prev, this.next);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: AppTheme.getFont(),
            children: this.getCompared(this.prev, this.next)));
  }

  List<TextSpan> getCompared(String prev, String next) {
    List<TextSpan> compared = [];
    List<Diff> diffs = diffLine(prev, next);
    for (Diff diff in diffs) {
      if (diff.op == EQUAL)
        compared.add(TextSpan(text: diff.text));
      else {
        compared.add(TextSpan(
            text: diff.text,
            style: getTextStyle(
                color: AppTheme.colors.fontPalette[diff.op == DELETE ? 2 : 0],
                backgroundColor: diff.op == DELETE
                    ? AppTheme.colors.pointRed.withAlpha(70)
                    : AppTheme.colors.primary
                    .withAlpha(70)))); // diff.op == INSERT
      }
    }
    return compared;
  }
}
