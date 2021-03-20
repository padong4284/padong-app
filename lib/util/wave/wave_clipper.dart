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
import 'package:padong/util/wave/wave.dart';

class WaveClipper extends CustomClipper<Path> {
  Wave wave;
  bool isBottom;
  bool isStatic;
  bool isReversed;
  int staticIdx;

  WaveClipper(this.wave, {this.isBottom = false});

  WaveClipper.static(this.staticIdx,
      {this.isBottom = true, this.isReversed = false})
      : this.isStatic = true;

  @override
  getClip(Size size) {
    if (this.isStatic) {
      this.wave = Wave(size.height / (8 + this.staticIdx), 0,
          (2 + this.staticIdx / 2) * size.height / 5, 5 + rand.nextInt(3),
          isDynamic: true);
      for (int _ = 0; _ < rand.nextInt(2000); _++) this.wave.updating();
    }

    var path = new Path();
    double prevX = 0;
    double prevY = wave.points[0].y;
    double xGap = size.width / (wave.pointNum - 1);

    if (this.isBottom) path.moveTo(0, size.height);
    path.lineTo(prevX, prevY);
    for (int i = 1; i < wave.pointNum; i++) {
      double cx = (prevX + xGap * i) / 2;
      double cy = (prevY + wave.points[i].y) / 2;

      path.quadraticBezierTo(prevX, prevY, cx, cy);

      prevX = xGap * i;
      prevY = wave.points[i].y;
    }
    path.lineTo(prevX, prevY);

    if (this.isBottom)
      path.lineTo(size.width, size.height);
    else
      path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
