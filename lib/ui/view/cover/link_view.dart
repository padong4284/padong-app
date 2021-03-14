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
import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/card/photo_card.dart';
import 'package:padong/ui/widget/container/horizontal_scroller.dart';
import 'package:padong/ui/widget/tile/node/wiki_tile.dart';

class LinkView extends StatefulWidget {
  final Wiki wiki;

  LinkView(this.wiki);

  _LinkViewState createState() => _LinkViewState();
}

class _LinkViewState extends State<LinkView> {
  List<Wiki> backLinks = [];
  List<Wiki> frontLinks = [];

  @override
  void initState() {
    super.initState();
    this.getLinks();
  }

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
            children: this.backLinks.map((wiki) => PhotoCard(wiki)).toList()),
        Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 5),
            child: Text('Front Links',
                style: AppTheme.getFont(
                    fontSize: AppTheme.fontSizes.mlarge, isBold: true))),
        ...this.frontLinks.map((wiki) => WikiTile(wiki))
      ],
    );
  }

  void getLinks() async {
    this.backLinks = [];
    this.frontLinks = [];
    List<Wiki> links = await widget.wiki.getLinks();
    setState(() {
      for (Wiki link in links) {
        if (widget.wiki.backLinks.contains(link.id))
          this.backLinks.add(link);
        else
          this.frontLinks.add(link);
      }
    });
  }
}
