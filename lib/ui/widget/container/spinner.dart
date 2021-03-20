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

const double halfPi = pi / 2;

class Spinner extends StatefulWidget {
  final double radius;
  final List<Widget> actions;
  final Widget child;
  final double resistance;
  final double actionSize;
  final double padding;
  final double initAngle;
  final Color color;
  final bool isShadow;

  Spinner(
      {@required this.radius,
      @required this.actions,
      @required this.actionSize,
      this.child,
      color,
      this.padding = 10,
      this.initAngle = 0,
      this.resistance = 0.7,
      this.isShadow = true})
      : assert(resistance > 0),
        this.color = color ?? AppTheme.colors.primary;

  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  double angle = 0;
  double dAngle = 0;
  double originAngle = 0;
  AnimationController _animationController;
  Animation<double> _animation;
  bool startAnimate = true;

  @override
  void initState() {
    super.initState();
    this.angle = widget.initAngle;
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
        onPanStart: this._prepare,
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
                          ? [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  spreadRadius: 3)
                            ]
                          : []),
                  child: Transform.rotate(
                      angle: -this.angle,
                      child: widget.child ?? SizedBox.shrink())),
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

  void _prepare(DragStartDetails details) {
    RenderBox spinner = context.findRenderObject();
    Offset offset = spinner.globalToLocal(details.globalPosition);
    this.originAngle = atan2(offset.dx - widget.radius, widget.radius - offset.dy);
  }

  void _rotate(DragUpdateDetails details) {
    RenderBox spinner = context.findRenderObject();
    Offset offset = spinner.globalToLocal(details.globalPosition);
    double angle = atan2(offset.dx - widget.radius, widget.radius - offset.dy);
    if (mounted)
      setState(() {
        this.dAngle = angle - this.originAngle;
        this.originAngle = angle;
        this.angle += this.dAngle;
      });
  }

  void _rotateFadeOut(DragEndDetails details) async {
    if (_animationController.isAnimating) return;
    int d = this.dAngle > 0 ? 1 : -1;
    double v = details.velocity.pixelsPerSecond.distance / 100;
    for (double i = v * d; (d > 0 ? i > 0 : i < 0); i /= 1.2) {
      await Future.delayed(Duration(milliseconds: 20));
      if (mounted) setState(() => this.angle += i / (100 * widget.resistance));
    }
  }
}
