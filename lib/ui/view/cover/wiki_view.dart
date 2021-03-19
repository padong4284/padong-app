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
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/view/cover/argue_view.dart';
import 'package:padong/ui/view/cover/history_view.dart';
import 'package:padong/ui/view/cover/item_view.dart';
import 'package:padong/ui/view/cover/link_view.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';

class WikiView extends StatelessWidget {
  final Wiki wiki;

  WikiView(this.wiki);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: BackAppBar(
                title: this.wiki.title,
                likeAndBookmark: this.wiki,
                bottom: this.topTabs()),
            body: TabBarView(
              physics: new NeverScrollableScrollPhysics(
                // to disable move tab when dragging
              ),
              children: [
                ItemView(this.wiki),
                ArgueView(this.wiki),
                LinkView(this.wiki),
                HistoryView(this.wiki),
              ],
            )));
  }

  Widget topTabs() {
    return Container(
        margin:
            const EdgeInsets.only(left: AppTheme.horizontalPadding, bottom: 5),
        alignment: Alignment.centerLeft,
        child: TabBar(
          labelColor: AppTheme.colors.fontPalette[0],
          labelStyle: AppTheme.getFont(
              fontSize: AppTheme.fontSizes.mlarge, isBold: true),
          unselectedLabelColor: AppTheme.colors.fontPalette[0],
          unselectedLabelStyle:
              AppTheme.getFont(fontSize: AppTheme.fontSizes.mlarge),
          indicator: UnderlineTabIndicator(
              // left align
              borderSide: BorderSide(width: 2, color: AppTheme.colors.support)),
          // no space between
          isScrollable: true,
          labelPadding: EdgeInsets.only(left: 0, right: 0),
          tabs: ['View', 'Argue', 'Link', 'History']
              .map((tab) => Padding(
                  padding: const EdgeInsets.only(left: 2, right: 10, bottom: 5),
                  child: Text(tab)))
              .toList(),
        ));
  }
}
