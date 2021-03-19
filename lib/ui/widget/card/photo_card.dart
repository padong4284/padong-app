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
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/node/mixin/statistics.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/bottom_buttons.dart';

class PhotoCard extends StatelessWidget {
  final Statistics node; // Post, Wiki, Building, Reply, ...etc

  PhotoCard(this.node);

  @override
  Widget build(BuildContext context) {
    return this.baseCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        this.pictureArea(),
        Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: this.titleArea()),
        BottomButtons(this.node, left: 8, hides: [1]),
      ]),
    );
  }

  Widget baseCard(
      {@required Widget child, double width = 140, double height = 220}) {
    return InkWell(
        onTap: () {
          PadongRouter.routeURL('/${this.node.type}?id=${this.node.id}', this.node);
        },
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width, maxHeight: height),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 3.0,
                margin: const EdgeInsets.all(5),
                child: child)));
  }

  Widget titleArea() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(this.node.title,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.getFont(
              color: AppTheme.colors.fontPalette[2], isBold: true)),
      SizedBox(
          height: 18,
          child: Text(this.node.description,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.getFont(color: AppTheme.colors.fontPalette[3])))
    ]);
  }

  Widget pictureArea({bool isRotated = false, double height = 130}) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.colors.lightSupport,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(isRotated ? 0 : 5),
              bottomLeft: Radius.circular(isRotated ? 5 : 0))),
      width: 140,
      height: height,
    );
  }
}
