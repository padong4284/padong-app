import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapSampleState();
}

class MapSampleState extends State<MapView> {
  String _mapStyle;
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _georgiaTech = CameraPosition(
    target: LatLng(33.775992835163144, -84.3962589592725),
    zoom: 14.4746,
    //bearing: 192.8334901395799,
    //tilt: 59.440717697143555,
  );

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      this._mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
          initialCameraPosition: this._georgiaTech,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(this._mapStyle);
            _controller.complete(controller);
          }),
    );
  }

  Future<void> _goToGT() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(this._georgiaTech));
  }
}
