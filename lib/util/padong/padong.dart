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
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:padong/core/shared/constants.dart';
import 'package:padong/util/padong/pado.dart';

Random rand = new Random();

class Padong {
  int padoNum;
  List<Pado> pados;

  Padong(double originY, List<Color> colors) {
    this.padoNum = colors.length;
    this.pados =
        List.generate(this.padoNum, (idx) => Pado(idx, originY, colors[idx]));
  }

  void update() {
    for (Pado pado in this.pados) pado.update();
  }

  void moveX(int x) {
    for (Pado pado in this.pados) pado.moveX(x);
  }

  void onKeyPressed(String key) {
    key = key.toUpperCase();
    for (List<String> line in KEYBOARDS)
      for (int i = 0; i < 4; i++)
        if (line[i].indexOf(key) >= 0) {
          int idx = line[i].indexOf(key);
          this.moveX(i < 2 ? idx : idx + i - 1);
          return;
        }
    this.moveX(DEFAULT_X);
  }
}

class PadongPainter extends CustomPainter {
  Padong padong;

  PadongPainter(this.padong);

  @override
  void paint(Canvas canvas, Size size) {
    for (Pado pado in this.padong.pados) pado.paint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
