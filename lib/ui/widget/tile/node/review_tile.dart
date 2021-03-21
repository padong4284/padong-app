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
import 'package:padong/core/node/schedule/review.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/star_rate_button.dart';
import 'package:padong/ui/widget/tile/node/node_tile.dart';

class ReviewTile extends NodeTile {
  final Review review;

  ReviewTile(this.review) : super(review, leftPadding: 8, isRoute: false);

  @override
  Widget followText() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      StarRateButton(rate: this.review.rate, size: 25, disable: true),
      Text(this.node.description,
          style: AppTheme.getFont(color: AppTheme.colors.support))
    ]);
  }

  @override
  Widget bottomArea(BuildContext context, {List<int> hides}) {
    return super.bottomArea(context, hides: [1, 2]);
  }
}
