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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/node/map/building.dart';
import 'package:padong/core/node/map/mappa.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/bottom_buttons.dart';
import 'package:padong/ui/widget/button/padong_button.dart';
import 'package:padong/ui/widget/button/simple_button.dart';
import 'package:padong/ui/widget/card/building_card.dart';
import 'package:padong/ui/widget/container/horizontal_scroller.dart';
import 'package:padong/ui/widget/container/tip_container.dart';
import 'package:padong/ui/widget/input/marker_selector.dart';
import 'package:padong/util/clipper/tip_clipper.dart';

class Pin {
  final String name;
  final LatLng loc;

  Pin(this.name, this.loc);
}

class MapTemplate extends StatefulWidget {
  final GoogleMap googleMap;
  final Function toMyLocation;
  final Function toUniversity;
  final Function(int idx) setMarkers;
  final Building focusBuilding;
  final Pin pinLocation;
  final bool hideCards;
  final Function(LatLng dest) navigateTo;
  final Mappa mappa;
  final List<Building> buildings;

  MapTemplate({
    @required this.googleMap,
    @required this.mappa,
    this.toMyLocation,
    this.toUniversity,
    this.setMarkers,
    this.focusBuilding,
    this.pinLocation,
    this.hideCards,
    this.navigateTo,
    this.buildings,
  });

  @override
  _MapTemplateState createState() => _MapTemplateState();
}

class _MapTemplateState extends State<MapTemplate> {
  bool hideCards = false;

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      background: Stack(children: [
        widget.googleMap,
        widget.focusBuilding != null
            ? this.buildingInfoWindow()
            : SizedBox.shrink(),
        widget.pinLocation != null
            ? this.pinLocationWindow()
            : SizedBox.shrink(),
      ]),
      children: [
        SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          this.myLocationButton(),
          MarkerSelector(setMarkers: widget.setMarkers),
        ]),
      ],
      floatingBottomBar: this.bottomBuildingCards(),
      floatingActionButtonGenerator: (isScrollingDown) => PadongButton(
          isScrollingDown: isScrollingDown,
          onPressAdd: widget.toUniversity,
          replaceAddIcon: Icons.school_rounded,
          noShadow: true),
    );
  }

  Widget myLocationButton() {
    return SizedBox(
        width: 40,
        height: 40,
        child: RaisedButton(
          elevation: 3.0,
          color: AppTheme.colors.base,
          padding: const EdgeInsets.all(0),
          shape: CircleBorder(),
          child: Icon(Icons.my_location_rounded,
              color: AppTheme.colors.primary, size: 25),
          onPressed: widget.toMyLocation,
        ));
  }

  Widget bottomBuildingCards() {
    if (widget.hideCards)
      setState(() {
        this.hideCards = true;
      });
    return widget.buildings.isNotEmpty
        ? GestureDetector(
            onVerticalDragUpdate: (detail) => setState(() {
                  this.hideCards = (detail.localPosition.direction > 0);
                }),
            child: AnimatedContainer(
                transform: Matrix4.translationValues(
                    0.0, this.hideCards ? 113.0 : 0, 0.0),
                duration: Duration(milliseconds: 150),
                height: 150,
                child: HorizontalScroller(height: 150, children: [
                  ...List.generate(min(10, widget.buildings.length),
                      (idx) => BuildingCard(widget.buildings[idx])), //FIXME
                  SizedBox(width: 60)
                ])))
        : SizedBox.shrink();
  }

  Widget buildingInfoWindow() {
    return Container(
        padding: const EdgeInsets.only(bottom: 120),
        alignment: Alignment.center,
        child: InkWell(
          onTap: () =>
              PadongRouter.routeURL('/building?id=${widget.focusBuilding.id}'),
          child: TipContainer(
              height: 100,
              radius: 10,
              anchorAlignment: AnchorAlignment.CENTER,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.focusBuilding.title,
                          style: AppTheme.getFont(isBold: true)),
                      Text(widget.focusBuilding.description,
                          style: AppTheme.getFont(
                              color: AppTheme.colors.fontPalette[3]),
                          overflow: TextOverflow.ellipsis),
                      BottomButtons(widget.focusBuilding)
                    ]),
              )),
        ));
  }

  Widget pinLocationWindow() {
    return Container(
      padding: const EdgeInsets.only(bottom: 120),
      alignment: Alignment.center,
      child: TipContainer(
          height: 100,
          radius: 10,
          anchorAlignment: AnchorAlignment.CENTER,
          child: Stack(children: [
            Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.pinLocation.name,
                          style: AppTheme.getFont(isBold: true)),
                      SimpleButton(
                        ' Navigate',
                        icon: Icon(Icons.near_me_rounded,
                            color: AppTheme.colors.primary, size: 15),
                        onTap: () => widget.navigateTo(widget.pinLocation.loc),
                      ),
                    ])),
            Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(right: 10, bottom: 15),
                child: InkWell(
                    onTap: () => PadongRouter.routeURL(
                        '/pin?id=${widget.mappa.id}&type=mappa&lat=${widget.pinLocation.loc.latitude}&lng=${widget.pinLocation.loc.longitude}',
                        widget.mappa),
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.5),
                        color: AppTheme.colors.support,
                      ),
                      child: Icon(Icons.add_rounded,
                          color: AppTheme.colors.base, size: 15),
                    )))
          ])),
    );
  }
}
