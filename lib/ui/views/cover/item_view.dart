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
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/widgets/title_header.dart';

class ItemView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> wiki;

  ItemView(wikiId)
      : this.id = wikiId,
        this.wiki = getWikiAPI(wikiId);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingActionButtonGenerator: (isScrollingDown) =>
            PadongFloatingButton(
                isScrollingDown: isScrollingDown, bottomPadding: 40),
        floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
            title: 'Edit',
            onTap: () {
              PadongRouter.routeURL(
                  'edit?id=${this.wiki['parentId']}&wikiId=${this.id}');
            },
            isScrollingDown: isScrollingDown),
        children: [
          Column(children: [
            TitleHeader(this.wiki['title'], link: "/wiki?id=${this.id}"),
            PadongMarkdown(this.wiki['description'])
          ]),
        ]);
  }
}
