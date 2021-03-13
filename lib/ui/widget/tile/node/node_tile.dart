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
import 'package:padong/core/node/node.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/node_base.dart';

class NodeTile extends NodeBase {
  final double leftPadding;

  NodeTile(Node node, {noProfile = false, this.leftPadding = 0.0, isRoute = true})
      : super(node, noProfile: noProfile, isRoute: isRoute);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: this.leftPadding),
        child: Column(children: [
          Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: super.build(context)),
          this.underLine()
        ]));
  }

  Widget underLine() {
    return Container(
        height: 2,
        color: AppTheme.colors.lightSupport,
        margin: const EdgeInsets.only(top: 5));
  }

  void moreCallback() {
    // TODO: Click more button " ... "
  }
}
