import 'package:padong/core/node/title_node.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// parent: PADONG (one and only)
class University extends TitleNode {
  String emblemImgURL;
  LatLng location;

  University.fromMap(String id, Map snapshot)
      : this.emblemImgURL = snapshot['emblemImgURL'],
        this.location = LatLng.fromJson(snapshot['location']),
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'emblemImgURL': this.emblemImgURL,
      'location': this.location.toJson(),
    };
  }
}
