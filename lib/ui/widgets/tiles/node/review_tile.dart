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
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';
import 'package:padong/ui/widgets/buttons/star_rate_button.dart';

class ReviewTile extends NodeBaseTile {
  ReviewTile(id) : super(id, leftPadding: 8, isRoute: false);

  @override
  Widget followText() {
    return Column(children: [
      StarRateButton(rate: this.node['rate'], size: 25, disable: true),
      Text(this.node['description'],
          style: AppTheme.getFont(
              color: AppTheme.colors.support))
    ]);
  }

  @override
  Widget bottomArea() {
    this.node['bottoms'][1] = null;
    this.node['bottoms'][2] = null;
    return super.bottomArea();
  }
}
