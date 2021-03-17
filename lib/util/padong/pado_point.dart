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

const int POINT_NUM = 5;
Random rand = new Random();

class PadoPoint {
  double y;
  double originY;
  double speed = 0.03 + rand.nextDouble() * 0.02; // 0.04 ~ 0.06
  int direction;
  double cur;
  double minAmp = rand.nextDouble() * 5;
  double maxAmp;
  double amplitude;
  bool isPulsing; // -1: decrease, 0: stay, 1: increase

  PadoPoint(this.y, int idx, int waveIdx, bool isEnd) {
    this.originY = this.y;
    this.direction = 1 - 2 * (idx % 2);
    this.cur = idx + waveIdx + 0.0;
    this.maxAmp = isEnd
        ? 3
        : 30 + rand.nextDouble() * 30 + (idx == POINT_NUM ~/ 2 ? 10 : 0);
    this.amplitude = this.minAmp;
    this.isPulsing = false;
  }

  void update() {
    this.cur += this.speed;
    this.y = this.originY + sin(this.cur) * this.amplitude;
  }

  void pulse() {
    if (!this.isPulsing) this._startPulse();
  }

  void _startPulse() async {
    this.isPulsing = true;
    while (this.amplitude < this.maxAmp) {
      this.amplitude += 0.5 + rand.nextDouble() / 10 +  this.speed;
      await Future.delayed(Duration(milliseconds: 8));
    }
    this._endPulse();
  }

  void _endPulse() async {
    while (this.minAmp < this.amplitude) {
      this.amplitude -= 0.5 + rand.nextDouble() / 10 + this.speed;
      await Future.delayed(Duration(milliseconds: 10));
    }
    this.amplitude = this.minAmp;
    this.isPulsing = false;
  }
}
