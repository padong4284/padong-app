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
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/card/base_card.dart';

class UniversityCard extends StatelessWidget {
  final University univ;

  UniversityCard(this.univ);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        // TODO: use emblem
        onTap: this.moveUniversity,
        child: BaseCard(
            padding: 25,
            width: MediaQuery.of(context).size.width -
                AppTheme.horizontalPadding * 2,
            height: 135,
            children: [
              SizedBox(height: 2),
              Text(this.univ.title,
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[1],
                      fontSize: AppTheme.fontSizes.large,
                      isBold: true)),
              Container(
                  height: 30,
                  margin: const EdgeInsets.only(top: 6, bottom: 9),
                  child: Text(this.univ.description,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.getFont(
                          color: AppTheme.colors.fontPalette[2]))),
            ]));
  }

  void moveUniversity() async {
    await Session.changeCurrentUniversity(this.univ);
    PadongRouter.routeURL('/main');
  }
}
