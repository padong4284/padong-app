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
import 'package:padong/core/node/deck/re_reply.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/tile/node/node_tile.dart';

class ReReplyTile extends NodeTile {
  ReReplyTile(ReReply reReply)
      : super(reReply, leftPadding: 40, isRoute: false);

  @override
  Widget followText() {
    return Text(this.node.description,
        style: AppTheme.getFont(color: AppTheme.colors.support));
  }

  @override
  Widget bottomArea(BuildContext context, {List<int> hides}) {
    return super.bottomArea(context, hides: [1, 2]);
  }
}
