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
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/shared/validator.dart' as Validator;
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/svgWrapper/svg_wrapper.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/widgets/cards/photo_card.dart';
import 'package:padong/ui/widgets/cards/summary_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/containers/swipe_deck.dart';
import 'package:padong/ui/widgets/univ_door.dart';
import 'package:padong/core/apis/session.dart' as Session;

import 'package:http/http.dart' as http;

class CoverView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> cover;

  CoverView()
      : this.id = Session.currentUniv['coverId'],
        this.cover = getCoverAPI(Session.currentUniv['coverId']);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          onPressAdd: () {
            PadongRouter.routeURL('edit?id=${this.id}');
          },
          isScrollingDown: isScrollingDown),
      title: 'Wiki',
      children: [
        UnivDoor(),
        this.emblemArea(),
        SizedBox(height: 30),
        SwipeDeck(
            children: this // TODO: from university
                .cover['fixedWikis']
                .values
                .map((wikiId) => SummaryCard(wikiId))
                .toList()),
        Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 5),
            child: Text('Recently Edited',
                style: AppTheme.getFont(
                    fontSize: AppTheme.fontSizes.mlarge, isBold: true))),
        HorizontalScroller(
            padding: 3.0,
            children: get10RecentWikiIdsAPI(this.id)
                .map((wikiId) => PhotoCard(wikiId, isWiki: true))
                .toList()),
        SizedBox(height: 40),
      ],
    );
  }

  Future<Uint8List> convertToSvgUri(String url) async {
  var res = await http.read(Uri.parse(url));
  url = "https:"+res.split("fullMedia\"><p><a href=\"")[1].split("\"")[0];
  return await http.readBytes(Uri.parse(url));
  }

  Widget emblemArea() {
    RegExp chkSvgPath = RegExp(r"https:\/\/\w\w\.wikipedia.+\.svg");
    ImageProvider emblem=null;
    String emblemImgURL = Session.currentUniv['emblem'];
    if (emblemImgURL != null){
      if (Validator.isValid(chkSvgPath, emblemImgURL )){
        emblem = SvgNetwork(emblemImgURL, httpHooker: convertToSvgUri);
      } else {
        emblem = NetworkImage(emblemImgURL);
      }
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
          Text(this.cover['loc'], style: AppTheme.getFont())
        ]));
  }
}
