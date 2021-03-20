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
import 'package:flutter/cupertino.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/util/wave/wave_clipper.dart';

class PadongWave extends StatelessWidget {
  final List<Color> colors;

  PadongWave([List<Color> colors])
      : this.colors = colors ??
            [
              AppTheme.colors.primary.withAlpha(0x8F),
              AppTheme.colors.primary.withAlpha(0x9F),
              AppTheme.colors.primary.withAlpha(0xAF),
            ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
          this.colors.length,
          (idx) => Container(
                  child: ClipPath(
                clipper: WaveClipper.static(idx, isReversed: idx % 2 != 0),
                child: Container(color: this.colors[idx]),
              ))),
    );
  }
}
