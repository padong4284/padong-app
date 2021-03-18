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
import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/card/base_card.dart';

class SummaryCard extends StatelessWidget {
  final Wiki wiki;

  SummaryCard(this.wiki);

  @override
  Widget build(BuildContext context) {
    return BaseCard(
        width: // for draggable
            MediaQuery.of(context).size.width - AppTheme.horizontalPadding * 2,
        height: 160,
        onTapMore: () {
          PadongRouter.routeURL('/wiki?id=${this.wiki.id}', this.wiki);
        },
        children: [
          SizedBox(height: 2),
          Text(this.wiki.title,
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[1],
                  fontSize: AppTheme.fontSizes.large,
                  isBold: true)),
          Container(
              height: 70,
              margin: const EdgeInsets.only(top: 6, bottom: 9),
              child: Text(this.wiki.description,
                  overflow: TextOverflow.ellipsis,
                  style:
                      AppTheme.getFont(color: AppTheme.colors.fontPalette[2]))),
        ]);
  }
}
