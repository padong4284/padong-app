import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/shared/statistics.dart';
import 'package:padong/core/shared/types.dart';

// parent: Mappa
class Building extends TitleNode with Statistics {
  LatLng location;
  int serviceCheckBits; // TODO transaction!

  Building();

  Building.fromMap(String id, Map snapshot)
      : this.location = LatLng.fromJson(snapshot['location']),
        this.serviceCheckBits = snapshot['serviceCheckBits'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Building.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'location': this.location.toJson(),
      'serviceCheckBits': this.serviceCheckBits,
    };
  }

  @override
  List<int> getStatistics() {
    List<int> statistics = super.getStatistics();
    statistics[1] = null;
    return statistics;
  }

  bool isServiceOn(SERVICE service) {
    // check bit mask with service's code
    return (this.serviceCheckBits & service.code) > 0;
  }
}
