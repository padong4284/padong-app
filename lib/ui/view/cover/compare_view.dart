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
import 'package:padong/core/node/cover/item.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/button/switch_button.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/padong_markdown.dart';
import 'package:padong/ui/widget/tile/node/post_tile.dart';
import 'package:padong/util/compare/diff_marker.dart';

class CompareView extends StatefulWidget {
  final Item item;

  CompareView(this.item);

  _CompareViewState createState() => _CompareViewState();
}

class _CompareViewState extends State<CompareView> {
  bool isPrev = false;

  @override
  Widget build(BuildContext context) {
    return CompareViewBase(
        widget.item,
        this.isPrev,
        (selected) => setState(() {
              this.isPrev = selected == 'compare';
            }));
  }
}

class CompareViewBase extends PostTile {
  final Item item;
  final bool isCompare;
  final Function checkCompare;

  CompareViewBase(this.item, this.isCompare, this.checkCompare) : super(item);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(appBar: this.viewAndCompare(), children: [
      Stack(children: [
        Hero(tag: 'node${this.item.id}owner', child: this.profile()),
        Hero(tag: 'node${this.item.id}common', child: this.commonArea())
      ]),
      TitleHeader(this.item.title, link: "/wiki?id=${this.item.parentId}"),
      this.isCompare
          ? DiffMarker(this.item.prevDescription, this.item.description)
          : PadongMarkdown(this.item.description),
      SizedBox(height: 20),
    ]);
  }

  @override
  Widget commonArea() {
    return Container(
        height: 40,
        padding: EdgeInsets.only(left: 47, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: this.topText()), this.time()],
          )
        ]));
  }

  Widget viewAndCompare() {
    return BackAppBar(
      switchButton: SwitchButton(
        options: ['view', 'compare'],
        onChange: this.checkCompare,
      ),
      actions: [
        Button(
            'Revert',
            buttonSize: ButtonSize.SMALL,
            borderColor: AppTheme.colors.primary,
            onTap: this.item.revertWikiToThisItem,
            shadow: false)
      ],
    );
  }
}
