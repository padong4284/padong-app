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
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/widget/tile/node/node_tile.dart';

class PostTile extends NodeTile {
  final String url;

  PostTile(Post post, {this.url}) : super(post);

  @override
  void routePage() => PadongRouter.routeURL(
      '/${this.url ?? this.node.type}?id=${this.node.id}&type=${this.node.type}',
      this.node);
}
