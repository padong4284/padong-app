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
import "dart:math";

Random rand = new Random();

class WavePoint {
  double cur;
  double y;
  double yNorm;
  double amplitude;
  double speed = 0.05 + rand.nextInt(10) / 500;

  WavePoint(amp, this.cur, this.yNorm) {
    this.amplitude = rand.nextDouble() * 15 + amp;
    this.y = this.yNorm + this.amplitude * sin(this.cur);
  }

  updating() {
    this.cur += this.speed;
    this.y = this.yNorm + this.amplitude * sin(this.cur);
  }

  moveYNorm(double dy) {
    this.yNorm += dy;
    this.y += dy;
  }
}

class Wave {
  double amplitude;
  double lean;
  double yNorm;
  int pointNum;
  bool isDynamic;
  List<WavePoint> points = [];

  Wave(this.amplitude, this.lean, this.yNorm, this.pointNum,
      {this.isDynamic = false})
      : this.points = List.generate(
            pointNum,
            (i) => WavePoint(
                !isDynamic && (i % (pointNum - 1) == 0) ? 0 : amplitude,
                i.toDouble(),
                yNorm + lean * i));

  void updating() {
    for (int i = this.isDynamic ? 0 : 1;
        i < this.pointNum - (this.isDynamic ? 0 : 1);
        i++) this.points[i].updating();
  }

  void moveYNorm(double dy) {
    this.yNorm += dy;
    for (WavePoint point in this.points) point.moveYNorm(dy);
  }
}
