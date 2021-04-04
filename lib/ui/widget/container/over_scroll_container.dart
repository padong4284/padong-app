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

class OverScrollContainer extends StatefulWidget {
  final Widget child;
  final int count;
  final double dragExtentPercentage;

  OverScrollContainer({
    @required this.child,
    @required this.count,
    this.dragExtentPercentage = 0.2,
  });

  @override
  _OverScrollContainerState createState() => _OverScrollContainerState();
}

class _OverScrollContainerState extends State<OverScrollContainer> {
 double _dragOffset = 0;
 IndexCalculator indexCalculator;

 @override
 void initState() {
    super.initState();
    this.indexCalculator = IndexCalculator(widget.count);
  }

  @override
  Widget build(BuildContext context) {
    return  NotificationListener<ScrollNotification>(
        onNotification: this._handleScroll,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: this._handleOverscroll,
          child: widget.child,
        )
    );
  }

  bool _handleScroll(ScrollNotification notification) {
   double extent = notification.metrics.viewportDimension;
   if (notification is ScrollUpdateNotification)
     this._dragOffset -= notification.scrollDelta;
   if (notification is OverscrollNotification)
     this._dragOffset -= notification.overscroll;

   double percent = (this._dragOffset / (extent * widget.dragExtentPercentage));
   double progress = percent.clamp(0.0, 1.0);
   this.indexCalculator.calculateIndex(progress);

   return false;
  }

  bool _handleOverscroll(OverscrollIndicatorNotification notification) {
   if (notification.depth != 0 || notification.leading) return false;
   notification.disallowGlow();
   return false;
  }
}

class IndexCalculator {
  final int count;
  int index;

  IndexCalculator(this.count);

  int calculateIndex(double progress){
    this.index = 0;
    return this.index;
  }
}