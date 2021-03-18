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
import 'package:padong/core/node/map/building.dart';
import 'package:padong/core/node/map/service.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/bottom_buttons.dart';
import 'package:padong/ui/widget/button/floating_bottom_button.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/card/location_card.dart';
import 'package:padong/ui/widget/card/service_card.dart';
import 'package:padong/ui/widget/input/marker_selector.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/padong_markdown.dart';

class BuildingView extends StatefulWidget {
  final Building building;

  BuildingView(this.building);

  _BuildingViewState createState() => _BuildingViewState();
}

class _BuildingViewState extends State<BuildingView> {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) =>
          PadongButton(isScrollingDown: isScrollingDown, bottomPadding: 40),
      floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
          title: 'Serve',
          onTap: () {
            PadongRouter.refresh = () => setState(() {});
            PadongRouter.routeURL(
                '/serve?id=${widget.building.id}&type=building',
                widget.building);
          },
          isScrollingDown: isScrollingDown),
      appBar: BackAppBar(
          title: widget.building.title, likeAndBookmark: widget.building),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: PadongMarkdown(widget.building.description),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 30),
            child: LocationCard(widget.building.location)),
        ...this.servicesLine(),
        SizedBox(height: 10),
        PadongFutureBuilder(
            future: widget.building.getChildren(Service(), upToDate: true),
            builder: (services) => Column(children: [
                  ...services.map((service) => ServiceCard(service))
                ])),
      ],
    );
  }

  List<Widget> servicesLine() {
    return [
      Stack(children: [
        Padding(
            padding: const EdgeInsets.only(top: 15),
            child: BottomButtons(widget.building, gap: 20)),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox.shrink(),
          MarkerSelector(fixedBitMask: widget.building.serviceCheckBits)
        ]),
      ]),
      Container(
          height: 2,
          margin: const EdgeInsets.only(top: 10),
          color: AppTheme.colors.lightSupport),
    ];
  }
}
