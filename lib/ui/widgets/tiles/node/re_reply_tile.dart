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

class ReReplyTile extends NodeBaseTile {
  ReReplyTile(id) : super(id, leftPadding: 40, isRoute: false);

  @override
  Widget followText() {
    return Text(this.node['description'],
        style: AppTheme.getFont(color: AppTheme.colors.support));
  }

  @override
  Widget bottomArea() {
    this.node['bottoms'][1] = null;
    this.node['bottoms'][2] = null;
    return super.bottomArea();
  }
}
