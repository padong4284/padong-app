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
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/core/padong_router.dart';

class PadongButton extends StatelessWidget {
  final Function onPressAdd;
  final bool isScrollingDown;
  final double bottomPadding;
  final IconData replaceAddIcon;

  PadongButton(
      {this.onPressAdd,
      this.isScrollingDown = false,
      this.bottomPadding = 0,
      this.replaceAddIcon});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Container(
            padding: EdgeInsets.only(right: 10.0, bottom: 10.0 + bottomPadding),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              this.onPressAdd != null
                  ? AnimatedOpacity(
                      opacity: this.isScrollingDown ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 300),
                      child: FloatingActionButton(
                        heroTag: null,
                        child: Icon(this.replaceAddIcon ?? Icons.add,
                            color: AppTheme.colors.base, size: 30),
                        backgroundColor: AppTheme.colors.support,
                        onPressed: this.onPressAdd,
                      ))
                  : SizedBox.shrink(),
              SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                  opacity: this.isScrollingDown ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 600),
                  child: FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.search,
                          color: AppTheme.colors.base, size: 30),
                      backgroundColor: AppTheme.colors.primary,
                      onPressed: () {
                        PadongRouter.routeURL('/search');
                      }))
            ])));
  }
}
