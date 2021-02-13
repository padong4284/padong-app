import "dart:math";

var rand = new Random();

class Point {
  double cur;
  double y;
  double yNorm;
  double amplitude;
  double speed = 0.05 + rand.nextInt(10) / 500;

  Point(amp, this.cur, this.yNorm) {
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
  List<Point> points = [];

  Wave(this.amplitude, this.lean, this.yNorm, this.pointNum) {
    for (int i = 0; i < this.pointNum; i++) {
      this.points.add(new Point(
          (i == 0 || i == this.pointNum - 1) ? 0 : this.amplitude,
          i.toDouble(),
          yNorm + lean * i));
    }
  }

  updating() {
    for (int i = 1; i < this.pointNum - 1; i++) {
      this.points[i].updating();
    }
  }

  moveYNorm(double dy) {
    this.yNorm += dy;
    for (int i = 0; i < this.pointNum; i++) {
      this.points[i].moveYNorm(dy);
    }
  }
}
