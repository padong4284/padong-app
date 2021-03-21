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

class ItemView extends StatefulWidget {
  final Wiki wiki;

  ItemView(this.wiki);

  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) =>
            PadongButton(isScrollingDown: isScrollingDown, bottomPadding: 40),
        floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
            title: 'Edit',
            onTap: () {
              PadongRouter.refresh = () {print(widget.wiki.description); setState(() {});};
              PadongRouter.routeURL(
                  'edit?id=${widget.wiki.id}&type=wiki', widget.wiki);
            },
            isScrollingDown: isScrollingDown),
        children: [
          Column(children: [
            TitleHeader(widget.wiki.title, link: "/wiki?id=${widget.wiki.id}"),
            Container(
                alignment: Alignment.topLeft,
                child: PadongMarkdown(widget.wiki.description))
          ]),
        ]);
  }
}
