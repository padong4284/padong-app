import 'package:flutter/material.dart';

class TipClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = new Path();
    path.moveTo(20.0, 0);
    path.lineTo(size.width - 20.0, 0);
    path.arcToPoint(new Offset(size.width - 20.0, 40.0),
        radius: Radius.circular(20));
    path.lineTo(45.0, 40.0);
    path.lineTo(35.0, 50.0);
    path.lineTo(25.0, 40.0);
    path.lineTo(20.0, 40.0);
    path.arcToPoint(new Offset(20.0, 0.0), radius: Radius.circular(20));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
