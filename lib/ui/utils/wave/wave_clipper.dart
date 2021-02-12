import 'package:flutter/material.dart';
import 'wave.dart';

class WaveClipper extends CustomClipper<Path> {
  Wave wave;
  WaveClipper(this.wave);

  @override
  getClip(Size size) {
    var path = new Path();
    double prevX = 0;
    double prevY = wave.points[0].y;
    double xGap = size.width / (wave.pointNum - 1);

    path.lineTo(prevX, prevY);
    for (int i=1; i<wave.pointNum; i++) {
      double cx = (prevX + xGap * i) / 2;
      double cy = (prevY + wave.points[i].y) / 2;

      path.quadraticBezierTo(prevX, prevY, cx, cy);

      prevX = xGap * i;
      prevY = wave.points[i].y;
    }
    path.lineTo(prevX, prevY);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
