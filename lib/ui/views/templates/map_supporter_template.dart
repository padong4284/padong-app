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
import 'package:padong/core/node/map/building.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/cards/building_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/containers/tip_container.dart';
import 'package:padong/core/apis/session.dart' as Session;
import 'package:padong/ui/widgets/inputs/marker_selector.dart';

class Pin {
  final String name;
  final LatLng loc;

  Pin(this.name, this.loc);
}

class MapSupporterTemplate extends StatefulWidget {
  final GoogleMap googleMap;
  final Function toMyLocation;
  final Function toUniversity;
  final Function(int idx) setMarkers;
  final Building focusBuilding;
  final Pin pinLocation;
  final bool hideCards;
  final Function(LatLng dest) navigateTo;

  MapSupporterTemplate({
    @required this.googleMap,
    this.toMyLocation,
    this.toUniversity,
    this.setMarkers,
    this.focusBuilding,
    this.pinLocation,
    this.hideCards,
    this.navigateTo,
  });

  @override
  _MapSupporterTemplateState createState() => _MapSupporterTemplateState();
}

class _MapSupporterTemplateState extends State<MapSupporterTemplate> {
  bool hideCards = false;

  @override
  Widget build(BuildContext context) {
    return new SafePaddingTemplate(
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
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          isScrollingDown: isScrollingDown,
          onPressAdd: widget.toUniversity,
          replaceAddIcon: Icons.school_rounded),
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
    return GestureDetector(
        onVerticalDragUpdate: (detail) => setState(() {
              this.hideCards = (detail.localPosition.direction > 0);
            }),
        child: AnimatedContainer(
            transform:
                Matrix4.translationValues(0.0, this.hideCards ? 113.0 : 0, 0.0),
            duration: Duration(milliseconds: 150),
            height: 150,
            child: HorizontalScroller(height: 150, children: [
              // TODO: get building cards from API
              ...List.generate(10, (idx) => BuildingCard(Building())), //FIXME
              SizedBox(width: 60)
            ])));
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
                      BottomButtons(
                          bottoms: widget.focusBuilding.getStatistics())
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
                      TranspButton(
                        title: ' Navigate',
                        icon: Icon(Icons.near_me_rounded,
                            color: AppTheme.colors.primary, size: 15),
                        callback: () =>
                            widget.navigateTo(widget.pinLocation.loc),
                      ),
                    ])),
            Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(right: 10, bottom: 15),
                child: InkWell(
                    onTap: () => PadongRouter.routeURL(
                        'pin?id=${Session.currentUniv['mappaId']}&lat=${widget.pinLocation.loc.latitude}&lng=${widget.pinLocation.loc.longitude}'),
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
