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
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:padong/core/node/map/building.dart';
import 'package:padong/core/node/map/mappa.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/template/map_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/util/img_supporter/bitmap_icon_loader.dart';

class MapView extends StatefulWidget {
  final Mappa mappa;

  MapView(this.mappa);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  bool hideCards = false;
  List<Building> buildings = [];
  List<bool> isSelected = List.generate(SERVICE_CODES.length, (_) => false);

  String _mapStyle;
  Map<String, BitmapDescriptor> pinIcons = {};
  List<BitmapDescriptor> markerIcons = [];
  Completer<GoogleMapController> _controller = Completer();

  Map<String, Set<Marker>> _markers = {};

  Set<Marker> get selectedMarkers {
    Set<Marker> markers = {...this._markers['center'], ...this._markers['pin']};
    for (int idx = 0; idx < SERVICES.length; idx++)
      if (this.isSelected[idx])
        markers = {...markers, ...this._markers[SERVICES[idx]]};
    return markers;
  }

  LatLng myLocation;
  StreamSubscription<Position> positionStream;
  Building focusBuilding;
  Pin pinLocation;

  Set<Polyline> _polyLines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String _placeDistance; // navigate

  @override
  void initState() {
    super.initState();
    widget.mappa.getChildren(Building()).then((_buildings) =>
        setState(() => this.buildings = <Building>[..._buildings]));
    rootBundle.loadString('assets/map_style.json').then((style) {
      this._mapStyle = style;
    });
    this._markers['center'] = {};
    this._markers['pin'] = {};
    for (int code in SERVICE_CODES)
      this._markers[serviceToString(SERVICE(code))] = {};
    this._initMyLoc();
  }

  @override
  Widget build(BuildContext context) {
    return MapTemplate(
      mappa: widget.mappa,
      buildings: this.buildings,
      googleMap: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        markers: this.selectedMarkers,
        polylines: this._polyLines,
        zoomControlsEnabled: false,
        initialCameraPosition:
            CameraPosition(target: Session.currUniversity.location, zoom: 17.0),
        onMapCreated: this._onMapCreated,
        onCameraMoveStarted: () => setState(() {
          this.pinLocation = null;
          this.focusBuilding = null;
          this.hideCards = true;
        }),
        onCameraIdle: () => setState(() {
          this.hideCards = false;
        }),
        onTap: this.pinTheLocation,
      ),
      toMyLocation: () => this._moveCameraTo(this.myLocation),
      toUniversity: () => this._moveCameraTo(Session.currUniversity.location),
      focusBuilding: this.focusBuilding,
      pinLocation: this.pinLocation,
      hideCards: this.hideCards,
      // navigateTo: this.navigateTo,
      navigateTo: (_) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sorry, We have to pay Firebase,,'))),
      setMarkers: (int idx) => setState(() {
        this.pinLocation = null;
        this.focusBuilding = null;
        this.isSelected[idx] = !this.isSelected[idx];
      }),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(this._mapStyle);
    await this._initPinIcons();
    Building center = await Session.currUniversity.getChild(Building());
    setState(() {
      this._markers['center'] = {
        Marker(
            markerId: MarkerId(center.id),
            position: Session.currUniversity.location,
            icon: this.pinIcons['primary'],
            onTap: this.popInfoWindow(center))
      };
      for (Building building in this.buildings) {
        for (int code in SERVICE_CODES) // no service -> custom Marker
          if (building.isServiceOn(SERVICE(code)) || code == 16) {
            this._markers[serviceToString(SERVICE(code))].add(Marker(
                markerId: MarkerId(code.toString() + building.id),
                position: building.location,
                icon: this.markerIcons[code.bitLength - 1],
                onTap: this.popInfoWindow(building)));
            break;
          }
      }
    });
    this._controller.complete(controller);
  }

  void _initMyLoc() async {
    bool _enabled = await Geolocator.isLocationServiceEnabled();
    if (!_enabled) {
      _enabled = await Geolocator.isLocationServiceEnabled();
      if (!_enabled) return;
    }
    LocationPermission _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied ||
          _permission == LocationPermission.deniedForever) return;
    }
    Position curr = await Geolocator.getCurrentPosition();
    this.myLocation = LatLng(curr.latitude, curr.longitude);
    this.positionStream = Geolocator.getPositionStream().listen(
            (Position curr) => setState(
                () => this.myLocation = LatLng(curr.latitude, curr.longitude)
            ));
  }

  Future<void> _initPinIcons() async {
    for (String pin in ['primary', 'support', 'red', 'yellow'])
      this.pinIcons[pin] =
          await BitmapIconLoader.getBitmapIcon('assets/pinIcon/$pin.png', 125);
    for (String mk in ['library', 'restaurant', 'parking', 'medical', 'loc'])
      this.markerIcons.add(
          await BitmapIconLoader.getBitmapIcon('assets/pinIcon/$mk.png', 125));
  }

  void pinTheLocation(LatLng loc) {
    this._markers.remove('pin');
    this.pinLocation = null;
    this.focusBuilding = null;
    setState(() {
      this._markers['pin'] = {
        Marker(
            markerId: MarkerId('pin'),
            position: loc,
            icon: this.pinIcons['support'],
            onTap: () => this.popPinWindow(loc))
      };
    });
  }

  Function popInfoWindow(Building building) {
    return () async {
      if (this.focusBuilding == null || this.focusBuilding != building) {
        this._moveCameraTo(building.location);
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          this.focusBuilding = building;
        });
      } else
        setState(() {
          this.focusBuilding = null;
        });
    };
  }

  void popPinWindow(LatLng loc) async {
    if (this.pinLocation == null) {
      this._moveCameraTo(loc);
      await Future.delayed(Duration(milliseconds: 25));
      Address address = (await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(loc.latitude, loc.longitude)))[0];
      setState(() {
        this.pinLocation = Pin('${address.featureName}', loc);
      });
    } else
      setState(() {
        this.pinLocation = null;
        this._markers['pin'] = {};
      });
  }

  void _moveCameraTo(LatLng dest) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: dest, zoom: 17.0)));
  }

  void navigateTo(LatLng dest) async {
    double totalDistance = 0.0;
    PolylineResult result = await this
        .polylinePoints
        .getRouteBetweenCoordinates(
            "YOUR_GOOGLE_API_KEY_HERE",
            PointLatLng(this.myLocation.latitude, this.myLocation.longitude),
            PointLatLng(dest.latitude, dest.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      for (int i = 0; i < polylineCoordinates.length - 1; i++)
        totalDistance += _coordinateDistance(
            polylineCoordinates[i], polylineCoordinates[i + 1]);
    }

    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId('navigate'),
          color: AppTheme.colors.primary,
          points: polylineCoordinates);
      this._polyLines.add(polyline);
      this._placeDistance = totalDistance.toStringAsFixed(2);
    });
  }

  double _coordinateDistance(LatLng loc1, LatLng loc2) {
    const double p = 0.017453292519943295;
    var a = 0.5 -
        cos((loc2.latitude - loc1.latitude) * p) / 2 +
        cos(loc1.latitude * p) *
            cos(loc2.latitude * p) *
            (1 - cos((loc2.longitude - loc1.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }
}
