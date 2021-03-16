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
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:padong/core/node/cover/cover.dart';
import 'package:padong/core/node/cover/wiki.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/validator.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/card/photo_card.dart';
import 'package:padong/ui/widget/card/summary_card.dart';
import 'package:padong/ui/widget/component/univ_door.dart';
import 'package:padong/ui/widget/container/horizontal_scroller.dart';
import 'package:padong/ui/widget/container/swipe_deck.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/util/svgWrapper/svg_wrapper.dart';

class CoverView extends StatelessWidget {
  final Cover cover;

  CoverView(this.cover);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongButton(
          onPressAdd: () {
            PadongRouter.routeURL(
                'edit?id=${this.cover.id}&type=cover', this.cover);
          },
          isScrollingDown: isScrollingDown),
      title: 'Wiki',
      children: [
        UnivDoor(Session.currUniversity),
        this.emblemArea(),
        SizedBox(height: 30),
        PadongFutureBuilder(
            future: Session.currUniversity.getChildren(Wiki()),
            builder: (wikis) => SwipeDeck(
                  children: <Widget>[...wikis.map((wiki) => SummaryCard(wiki))],
                )),
        Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 5),
            child: Text('Recently Edited',
                style: AppTheme.getFont(
                    fontSize: AppTheme.fontSizes.mlarge, isBold: true))),
        PadongFutureBuilder(
            future: this.cover.getChildren(Wiki()),
            builder: (wikis) => HorizontalScroller(
                padding: 3.0,
                children: List.generate(min(10, wikis.length as int),
                    (idx) => PhotoCard(wikis[idx])))),
        SizedBox(height: 40),
      ],
    );
  }

  Widget emblemArea() {
    ImageProvider emblem;
    String emblemImgURL = Session.currUniversity.emblemImgURL;
    if (emblemImgURL != null) {
      if (Validator.isWikiSvg(emblemImgURL))
        emblem = SvgNetwork(emblemImgURL, httpHooker: this.convertWikiToSvg);
      else if (emblemImgURL.endsWith(".svg"))
        emblem = SvgNetwork(emblemImgURL);
      else
        emblem = NetworkImage(emblemImgURL);
    }

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 10)
                  ]),
              child: CircleAvatar(
                  radius: 32,
                  backgroundColor: AppTheme.colors.transparent,
                  backgroundImage: emblem)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.place_rounded,
                  color: AppTheme.colors.primary, size: 30)),
          Text(Session.currUniversity.address, style: AppTheme.getFont())
        ]));
  }
}
