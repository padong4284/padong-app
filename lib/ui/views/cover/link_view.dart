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
import 'package:padong/core/apis/cover.dart';
import 'package:padong/core/node/deck/post.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/cards/photo_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/tiles/node/wiki_item_tile.dart';

class LinkView extends StatelessWidget {
  final String id;

  LinkView(wikiId) : this.id = wikiId;

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 5),
            child: Text('Back Links',
                style: AppTheme.getFont(
                    fontSize: AppTheme.fontSizes.mlarge, isBold: true))),
        HorizontalScroller(
            padding: 3.0,
            children: getBackLinksAPI(this.id)
                .map((wikiId) => PhotoCard(Post())) //FIXME
                .toList()),
        Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 5),
            child: Text('Front Links',
                style: AppTheme.getFont(
                    fontSize: AppTheme.fontSizes.mlarge, isBold: true))),
        ...getFrontLinksAPI(this.id).map((id) => WikiItemTile(id))
      ],
    );
  }
}
