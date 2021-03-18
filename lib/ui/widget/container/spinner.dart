import 'dart:math';
import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

const double halfPi = pi / 2;

class Spinner extends StatefulWidget {
  final double radius;
  final List<Widget> actions;
  final double resistance;
  final double actionSize;
  final double padding;
  final Color color;
  final bool isShadow;

  Spinner(
      {@required this.radius,
      @required this.actions,
      @required this.actionSize,
      color,
      this.padding = 5,
      this.resistance = 0.7,
      this.isShadow = false})
      : assert(resistance > 0),
        this.color = color ?? AppTheme.colors.primary;

  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  double angle = 0;
  double dAngle = 0;
  AnimationController _animationController;
  Animation<double> _animation;
  bool startAnimate = true;

  @override
  void initState() {
    super.initState();
    this._animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    this._animation = Tween(begin: 0.0, end: 2 * pi).animate(CurvedAnimation(
        parent: this._animationController, curve: Curves.linear));
  }

  @override
  void dispose() {
    this._animationController.dispose(); // finish animation
    super.dispose(); // due to lifecycle, call after controller disposed
  }

  @override
  Widget build(BuildContext context) {
    int n = widget.actions.length;
    double r = widget.actionSize / 2;
    double rp = widget.radius - r - widget.padding;
    return GestureDetector(
        onPanUpdate: this._rotate,
        onPanEnd: this._rotateFadeOut,
        child: AnimatedBuilder(
            animation: this._animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: this.angle,
                child: child,
              );
            },
            child: Stack(children: [
              Container(
                  width: widget.radius * 2,
                  height: widget.radius * 2,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                      color: widget.color,
                      shape: BoxShape.circle,
                      boxShadow: widget.isShadow
                          ? [BoxShadow(color: Colors.black12, blurRadius: 15)]
                          : []),
                  child: Text('hello flutter')),
              ...List.generate(
                  n,
                  (i) => Positioned(
                      left: widget.radius - r + rp * cos(i * 2 * pi / n),
                      top: widget.radius - r - rp * sin(i * 2 * pi / n),
                      child: SizedBox(
                          width: widget.actionSize,
                          height: widget.actionSize,
                          child: Transform.rotate(
                              angle: -this.angle, child: widget.actions[i])))),
            ])));
  }

  void _rotate(DragUpdateDetails details) {
    RenderBox spinner = context.findRenderObject();
    Offset offset = spinner.globalToLocal(details.globalPosition);
    double angle = atan2(offset.dx - widget.radius, widget.radius - offset.dy);
    setState(() {
      this.dAngle = angle - this.angle;
      this.angle = angle;
    });
  }

  void _rotateFadeOut(DragEndDetails details) async {
    if (_animationController.isAnimating) return;
    int d = this.dAngle > 0 ? 1 : -1;
    double v = details.velocity.pixelsPerSecond.distance / 100;
    for (double i = v * d; (d > 0 ? i > 0 : i < 0); i /= 2) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() => this.angle += i / (50 * widget.resistance));
    }
  }
}
