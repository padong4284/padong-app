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
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/node_base.dart';

class ImageCard extends NodeBase {
  ImageCard(id) : super(id, noProfile: true);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        // TODO: routing
        onTap: () => PadongRouter.routeURL('/wiki?id=123'),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 1.5,
            child: Stack(children: [
              Container(
                  width: MediaQuery.of(context).size.width -
                      AppTheme.horizontalPadding * 2,
                  height: 120,
                  padding: EdgeInsets.all(10),
                  // TODO: get image from wiki
                  /* decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/pinIcon/loc.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                )), */
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(5),
                            child: Stack(children: [
                              Hero(
                                  tag: 'node${this.id}common',
                                  child: this.commonArea()),
                            ])),
                        Hero(
                            tag: 'node${this.id}bottoms',
                            child: this.bottomArea()),
                      ]))
            ])));
  }

  @override
  Widget topText() {
    return SizedBox.shrink();
  }

  @override
  Widget followText() {
    return Text(this.node['title'],
        style: TextStyle(
            height: 1.25,
            color: AppTheme.colors.fontPalette[1],
            letterSpacing: 0.025,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            fontSize: AppTheme.fontSizes.large,
            shadows: [Shadow(blurRadius: 10.0, color: AppTheme.colors.base)]));
  }

  @override
  Widget bottomArea() {
    this.node['bottoms'][1] = null;
    return Padding(
        padding: const EdgeInsets.only(top: 18, left: 5, right: 5),
        child: super.bottomArea());
  }
}
