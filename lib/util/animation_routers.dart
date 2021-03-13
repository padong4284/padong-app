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

const List<Offset> SLIDE = [
  Offset(0, 1), // to TOP
  Offset(-1, 0), // to RIGHT
  Offset(0, -1), // to BOTTOM
  Offset(1, 0) // to LEFT
];

PageRouteBuilder slideRouter(
    {Function(BuildContext, Animation<double>, Animation<double>) pageBuilder,
      int direction = 0}) {
  return PageRouteBuilder(
      pageBuilder: pageBuilder,
      transitionsBuilder: (BuildContext _, Animation<double> animation,
          Animation<double> __, Widget child) =>
          SlideTransition(
            position: animation.drive(
                Tween(begin: SLIDE[direction], end: Offset.zero)
                    .chain(CurveTween(curve: Curves.ease))),
            child: child,
          ));
}

PageRouteBuilder sizeRouter({
  Function(BuildContext, Animation<double>, Animation<double>) pageBuilder,
}) {
  return PageRouteBuilder(
      pageBuilder: pageBuilder,
      transitionsBuilder: (BuildContext _, Animation<double> animation,
          Animation<double> __, Widget child) =>
          Align(
            child: SizeTransition(sizeFactor: animation, child: child),
          ));
}

PageRouteBuilder fadeRouter({
  Function(BuildContext, Animation<double>, Animation<double>) pageBuilder,
}) {
  return PageRouteBuilder(
      pageBuilder: pageBuilder,
      transitionsBuilder: (BuildContext _, Animation<double> animation,
          Animation<double> __, Widget child) =>
          FadeTransition(
            opacity: animation,
            child: child,
          ));
}