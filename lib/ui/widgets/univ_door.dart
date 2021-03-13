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
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/theme/app_theme.dart';

class UnivDoor extends StatelessWidget {
  final String univName;
  final String slogan;

  UnivDoor()
      : this.univName = Session.currUniversity.title,
        this.slogan = Session.currUniversity.description;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                this.univName,
                style: AppTheme.getFont(
                    isBold: true,
                    color: AppTheme.colors.fontPalette[0],
                    fontSize: AppTheme.fontSizes.xlarge),
              )),
          Text(
            this.slogan,
            style: AppTheme.getFont(
                color: AppTheme.colors.fontPalette[2],
                fontSize: AppTheme.fontSizes.mlarge),
          )
        ]));
  }
}
