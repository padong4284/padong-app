import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';
import 'package:padong/ui/widgets/cards/building_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapSampleState();
}

class MapSampleState extends State<MapView> {
  String _mapStyle;
  Map<String, Marker> _markers;
  Completer<GoogleMapController> _controller = Completer();
  final List<IconData> icons = [
    Icons.local_library_rounded,
    Icons.restaurant_rounded,
    Icons.local_parking_rounded,
    Icons.medical_services_rounded,
    Icons.edit_location_rounded
  ];

  final CameraPosition _myUniv = CameraPosition(
    // TODO get my univ campus location from UNIV node
    target: LatLng(33.775792835163144, -84.3962589592725), // GT
    zoom: 17.0,
    //bearing: 192.8334901395799,
    //tilt: 59.440717697143555,
  );

  @override
  void initState() {
    super.initState();
    this._markers = {};
      rootBundle.loadString('assets/map_style.txt').then((style) {
      this._mapStyle = style;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SafePaddingTemplate(
      background: GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: this._myUniv,
          onMapCreated: this._onMapCreated,
          markers: {}// this._markers.values.toSet()
      ),
      children: [
        SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [this.myLocation(), this.selector()])
      ],
      floatingBottomBar: this.bottomBuildingCards(),
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          isScrollingDown: isScrollingDown, onPressAdd: () {}),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(this._mapStyle);
    _controller.complete(controller);
  }

  Future<void> _goToUniv() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(this._myUniv));
  }

  Widget myLocation() {
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
          onPressed: this._goToUniv, // TODO my location
        ));
  }

  Widget selector() {
    double height = 40.0;
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/2)),
        elevation: 3.0,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: Iterable<int>.generate(5)
                  .map((idx) => ToggleIconButton(
                        size: 25,
                        defaultIcon: this.icons[idx],
                        toggleColor: AppTheme.colors.primary,
                      ))
                  .toList()),
        ));
  }

  Widget bottomBuildingCards() {
    return HorizontalScroller(
        height: 150,
        children: Iterable<int>.generate(10)
            .map((idx) => BuildingCard(idx.toString()))
            .toList());
  }
}
