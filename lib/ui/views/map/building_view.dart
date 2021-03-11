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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/apis/map.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/cards/location_card.dart';
import 'package:padong/ui/widgets/cards/service_card.dart';
import 'package:padong/ui/widgets/inputs/marker_selector.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';

class BuildingView extends StatelessWidget {
  // TODO: PIP / Written, Replied, Liked, Bookmarked
  final String id;
  final Map<String, dynamic> building;

  BuildingView(id)
      : this.id = id,
        this.building = getBuildingAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          isScrollingDown: isScrollingDown, bottomPadding: 40),
      floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
          title: 'Serve',
          onTap: () {
            PadongRouter.routeURL('/serve?id=${this.id}');
          },
          isScrollingDown: isScrollingDown),
      appBar: BackAppBar(title: this.building['title'], actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {}) // TODO: more dialog
      ]),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: PadongMarkdown(this.building['description']),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 30),
            child: LocationCard(LatLng(gtLat, gtLng))),
        ...this.servicesLine(),
        SizedBox(height: 10),
        ...getServicesAPI(this.id).map((service) => ServiceCard(service)),
      ],
    );
  }

  List<Widget> servicesLine() {
    return [
      Stack(children: [
        Padding(
            padding: const EdgeInsets.only(top: 15),
            child: BottomButtons(bottoms: this.building['bottoms'])),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox.shrink(),
          MarkerSelector(fixedBitMask: this.building['serviceCheckBits'])
        ]),
      ]),
      Container(
          height: 2,
          margin: const EdgeInsets.only(top: 10),
          color: AppTheme.colors.lightSupport),
    ];
  }
}
