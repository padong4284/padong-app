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
import 'package:padong/core/node/common/university.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/top_app_bar.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/component/univ_door.dart';

class HomeView extends StatelessWidget {
  final University university;

  HomeView(this.university);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: TopAppBar('PADONG'),
      floatingActionButtonGenerator: (isScrollingDown) =>
          PadongButton(isScrollingDown: isScrollingDown),
      children: [
        //Button(title: 'INIT', callback: () async => await initUniversity()),
        UnivDoor(this.university),
        SizedBox(height: 35),
      ],
    );
  }

  Widget _title(String title) {
    return Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 5),
        child: Text(title,
            style: AppTheme.getFont(
                fontSize: AppTheme.fontSizes.mlarge, isBold: true)));
  }
}
