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
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/container/spinner.dart';

double iconSize = 45.0;

class ForgotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: BackAppBar(title: 'Forgot'),
      children: [
        Center(
            child: Spinner(
                radius: 150,
                isShadow: true,
                actions: [
                  Icon(Icons.home, size: iconSize),
                  Icon(Icons.wysiwyg, size: iconSize),
                  Icon(Icons.book, size: iconSize)
                ],
                actionSize: iconSize,
                padding: 20,
                resistance: 0.7,
                color: AppTheme.colors.support,
                child: Spinner(
                  radius: 90,
                  isShadow: true,
                  actions: [
                    Icon(Icons.home, size: iconSize),
                    Icon(Icons.wysiwyg, size: iconSize),
                    Icon(Icons.book, size: iconSize)
                  ],
                  actionSize: iconSize,
                  padding: 15,
                  resistance: 0.7,
                  child: FloatingActionButton(child: Icon(Icons.search)),
                )))
      ],
    );
  }
}
