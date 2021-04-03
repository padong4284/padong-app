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
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/tile/node/node_tile.dart';

class PostTile extends NodeTile {
  PostTile(Post post) : super(post);

  @override
  void routePage() => PadongRouter.routeURL(
      '/post?id=${this.node.id}&type=${this.node.type}',
      this.node);

  @override
  Widget followText() {
    return Text(this.node.title,
        maxLines: 1,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(color: AppTheme.colors.support, isBold: true));
  }
}
