import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:padong/core/viewmodels/table/memo.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapSampleState();
}

class MapSampleState extends State<MapView> {
  String _mapStyle;
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _georgiaTech = CameraPosition(
    target: LatLng(33.775992835163144, -84.3962589592725),
    zoom: 17.0,
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
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return new SafePaddingTemplate(
        background: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: this._georgiaTech,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(this._mapStyle);
              _controller.complete(controller);
            }),
      children: [],
    );
  }

  Future<void> _goToGT() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(this._georgiaTech));
  }
}
