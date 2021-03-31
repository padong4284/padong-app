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
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/validator.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/util/img_supporter/svg_wrapper.dart';

class UniversityCard extends StatelessWidget {
  final University univ;

  UniversityCard(this.univ);

  @override
  Widget build(BuildContext context) {
    ImageProvider _emblem = this.emblem();
    return InkWell(
        onTap: this.moveUniversity,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 1.5,
            child: Container(
                width: MediaQuery.of(context).size.width -
                    AppTheme.horizontalPadding * 2,
                height: 135,
                child: Stack(children: [
                  Positioned(
                      right: 10,
                      child: Container(
                        width: 160,
                        height: 120,
                        margin: const EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: _emblem,
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter)),
                      )),
                  Container(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2),
                            ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 50),
                                child: Text(this.univ.title,
                                    style: AppTheme.getFont(
                                        shadows: [
                                          Shadow(
                                              color: AppTheme.colors.base,
                                              blurRadius: 20)
                                        ],
                                        color: AppTheme.colors.fontPalette[1],
                                        fontSize: AppTheme.fontSizes.large,
                                        isBold: true))),
                            Container(
                                height: 15,
                                margin:
                                    const EdgeInsets.only(top: 6, bottom: 9),
                                child: Text(this.univ.description,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTheme.getFont(shadows: [
                                      Shadow(
                                          color: AppTheme.colors.base,
                                          blurRadius: 20)
                                    ], color: AppTheme.colors.fontPalette[2]))),
                          ]))
                ]))));
  }

  void moveUniversity() async =>
      await Session.changeCurrentUniversity(this.univ);

  ImageProvider emblem() {
    ImageProvider emblem;
    String emblemImgURL = this.univ.emblemImgURL;
    if (emblemImgURL != null) {
      if (Validator.isWikiSvg(emblemImgURL))
        emblem =
            SvgNetwork(emblemImgURL, httpHooker: SvgNetwork.convertWikiToSvg);
      else if (emblemImgURL.endsWith(".svg"))
        emblem = SvgNetwork(emblemImgURL);
      else
        emblem = NetworkImage(emblemImgURL);
    }
    return emblem;
  }
}
