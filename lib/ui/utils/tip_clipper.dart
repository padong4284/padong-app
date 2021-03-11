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

class TipClipper extends CustomClipper<Path> {
  final double radius;
  final double anchor;
  final AnchorAlignment anchorAlignment;

  TipClipper(
      {this.radius = 20,
      this.anchor = 10,
      this.anchorAlignment = AnchorAlignment.LEFT});

  @override
  getClip(Size size) {
    double anchorStart = this.anchorAlignment == AnchorAlignment.LEFT
        ? radius + 5
        : (this.anchorAlignment == AnchorAlignment.CENTER
            ? size.width / 2 - anchor
            : size.width - 5 - 2 * this.anchor);
    var path = new Path();
    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(new Offset(size.width, radius),
        radius: Radius.circular(radius));
    path.lineTo(size.width, size.height - radius - anchor);
    path.arcToPoint(new Offset(size.width - radius, size.height - anchor),
        radius: Radius.circular(radius));
    path.lineTo(anchorStart + 2 * anchor, size.height - anchor);
    path.lineTo(anchorStart + anchor, size.height);
    path.lineTo(anchorStart, size.height - anchor);
    path.lineTo(radius, size.height - anchor);
    path.arcToPoint(new Offset(0, size.height - radius - anchor),
        radius: Radius.circular(radius));
    path.lineTo(0, radius);
    path.arcToPoint(new Offset(radius, 0), radius: Radius.circular(radius));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

enum AnchorAlignment {
  LEFT,
  CENTER,
  RIGHT,
}
