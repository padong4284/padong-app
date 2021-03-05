import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/shared/statistics.dart';

// parent: Mappa
class Building extends TitleNode with Statistics {
  LatLng location;

  Building.fromMap(String id, Map snapshot)
      : this.location = LatLng.fromJson(snapshot['loc']),
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'loc': this.location.toJson(),
    };
  }

  /// TODO: check Library, Restaurant, Parking, Medical, Custom
  List<bool> checkServiceList() {
    return [
      false, // Library
      false, // Restaurant
      false, // Parking
      false, // Medical
      false, // Custom
    ];
  }
}
