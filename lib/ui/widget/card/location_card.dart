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
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/util/img_supporter/bitmap_icon_loader.dart';

class LocationCard extends StatefulWidget {
  final LatLng loc;
  final String mark;

  LocationCard(this.loc, {this.mark='primary'});

  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  Set<Marker> pinMarker = {};
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3.0,
        child: Container(
            height: 180,
            child: GoogleMap(
              initialCameraPosition:
              CameraPosition(target: widget.loc, zoom: 17.0),
              myLocationButtonEnabled: false,
              scrollGesturesEnabled: false,
              markers: this.pinMarker,
              zoomControlsEnabled: false,
              onMapCreated: this._onMapCreated,
            )));
  }

  void _onMapCreated(GoogleMapController controller) async {
    controller
        .setMapStyle(await rootBundle.loadString('assets/map_style.json'));
    BitmapDescriptor markerIcon =
    await BitmapIconLoader.getBitmapIcon('assets/pinIcon/${widget.mark}.png', 125);
    setState(() {
      this.pinMarker.add(Marker(
          markerId: MarkerId('${widget.loc.latitude}-${widget.loc.longitude}'),
          position: widget.loc,
          icon: markerIcon));
    });
    this._controller.complete(controller);
  }
}
