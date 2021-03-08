import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/service/padong_fb.dart';

// parent: PADONG (one and only)
class University extends TitleNode {
  String emblemImgURL;
  LatLng location;
  String address;

  University.fromMap(String id, Map snapshot)
      : this.emblemImgURL = snapshot['emblemImgURL'],
        this.location = LatLng.fromJson(snapshot['location']),
        this.address = snapshot['address'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'emblemImgURL': this.emblemImgURL,
      'location': this.location.toJson(),
      'address': this.address,
    };
  }

  static Future<University> getUniversityByName(String universityName) async {
    var results = await PadongFB.getNodesByRule(University,
        rule: (Query q) => (q.where("title", isEqualTo: universityName)));
    if (results.isEmpty) throw Exception("There's no University");
    return results.first;
  }
}
