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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongFutureBuilder extends StatelessWidget {
  final Future<dynamic> future;
  final Widget Function(dynamic data) builder;
  final double height;
  final double size;

  PadongFutureBuilder(
      {@required this.future,
      @required this.builder,
      this.size = 30,
      this.height});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
                height: this.height,
                alignment: Alignment.center,
                child: SizedBox(
                    width: this.size,
                    height: this.size,
                    child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('ERROR: ${snapshot.error}',
                    style: AppTheme.getFont(color: AppTheme.colors.pointRed)));
          } else
            return this.builder(snapshot.data);
        });
  }
}
