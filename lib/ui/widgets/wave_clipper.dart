import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WaveClipper extends CustomClipper<Path> {
  double amplitude = 50;
  double lean = 5;
  double verticalNorm = 90;

  @override
  getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - verticalNorm);
    var firstControlPoint = new Offset(size.width / 4, size.height - this.verticalNorm - this.lean + this.amplitude);
    var firstEndPoint = new Offset(size.width / 2, size.height - this.verticalNorm - 2*this.lean);
    var secondControlPoint = new Offset(size.width - (size.width / 4), size.height - this.verticalNorm - 3*this.lean - this.amplitude);
    var secondEndPoint = new Offset(size.width, size.height - this.verticalNorm - 4*this.lean);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper)
  {
    return true;
  }

}

class PrimaryWaveClipper extends WaveClipper {
  double amplitude = 60;
  double lean = 20;
  double verticalNorm = 80;
}

class SecondaryWaveClipper extends WaveClipper {
  double amplitude = -50;
  double lean = -30;
  double verticalNorm = 200;
}