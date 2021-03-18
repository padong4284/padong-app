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

class NoDataMessage extends StatelessWidget {
  final String message;
  final Alignment alignment;
  final double height;

  NoDataMessage(this.message,
      {this.alignment = Alignment.center, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.height,
        alignment: this.alignment,
        child: Text(this.message,
            textAlign: TextAlign.center,
            style: AppTheme.getFont(
                fontSize: AppTheme.fontSizes.mlarge,
                color: AppTheme.colors.primary,
                isBold: true)));
  }
}
