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
import 'package:padong/core/node/deck/reply.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/tile/node/node_tile.dart';

class ReplyTile extends NodeTile {
  ReplyTile(Reply reply) : super(reply, leftPadding: 8, isRoute: false);

  @override
  Widget followText() {
    return Text(this.node.description,
        style: AppTheme.getFont(color: AppTheme.colors.support));
  }

  @override
  Widget bottomArea({List<int> hides, bool isSubNode=true}) {
    return super.bottomArea(hides: [2], isSubNode: isSubNode);
  }
}
