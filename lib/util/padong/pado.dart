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
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/util/padong/pado_point.dart';

const int DEFAULT_X = 4;
const int KEY_TERM = 15;

Random rand = new Random();

class Pado {
  int idx;
  double currX = DEFAULT_X * 1.0;
  double originY;
  List<PadoPoint> points;
  Color color;

  Pado(this.idx, this.originY, this.color) {
    this.idx = rand.nextInt(10);
    this.points = List.generate(
        POINT_NUM,
        (idx) =>
            PadoPoint(this.originY, idx, this.idx, idx % (POINT_NUM - 1) == 0));
  }

  void moveX(int x) {
    this.currX = x * 1.0;
    for (PadoPoint point in this.points) point.pulse();
  }

  void update() {
    for (PadoPoint point in this.points) point.update();
  }

  void paint(Canvas canvas, Size size) {
    double padding = AppTheme.horizontalPadding;
    double pointGap = (size.width - padding * 2) / KEY_TERM;
    double startX = this.currX * pointGap + padding;

    Paint paint = Paint()
      ..color = this.color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    List<List<double>> _points = [
      [padding, this.originY]
    ];
    for (int i = 0; i < POINT_NUM; i++)
      _points.add([startX + (i + 1) * pointGap, this.points[i].y]);
    _points.add([size.width - padding, this.originY]);

    List<double> _prev = _points[0];
    path.moveTo(_prev[0], _prev[1]);
    for (int d = 0; d < 2; d++) {
      for (int i = POINT_NUM * d;
          (0 <= i) && (i <= POINT_NUM + 1);
          i += (1 - 2 * d)) {
        double _x = _points[i][0];
        double _y = (1 - 2 * d) * _points[i][1] + d * 2 * this.originY;

        double _cx = (_prev[0] + _x) / 2;
        double _cy = (_prev[1] + _y) / 2;

        path.quadraticBezierTo(_prev[0], _prev[1], _cx, _cy);
        _prev = [_x, _y];
      }
      path.lineTo(_prev[0], _prev[1]);
    }
    path.lineTo(padding, this.originY);
    path.close();
    canvas.drawPath(path, paint);
  }
}
