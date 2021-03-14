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
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/widget/button/floating_bottom_button.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/padong_markdown.dart';

class ItemView extends StatelessWidget {
  final Wiki wiki;

  ItemView(this.wiki);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) =>
            PadongButton(isScrollingDown: isScrollingDown, bottomPadding: 40),
        floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
            title: 'Edit',
            onTap: () => PadongRouter.routeURL(
                'edit?id=${this.wiki.id}&type=wiki', this.wiki),
            isScrollingDown: isScrollingDown),
        children: [
          Column(children: [
            TitleHeader(this.wiki.title, link: "/wiki?id=${this.wiki.id}"),
            Container(
                alignment: Alignment.topLeft,
                child: PadongMarkdown(this.wiki.description))
          ]),
        ]);
  }
}
