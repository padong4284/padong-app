import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padong/core/services/padong_fb.dart';

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

  static Future<University> getUniversityByTitle(String universityName) async {
    var results = await PadongFB.getNodesByRule(University,
        rule: (Query q) => (q.where("title", isEqualTo: universityName)),
    );
    if (results.isNotEmpty){
      return results.first;
    }else{
      throw Exception("There's no University");
    }
  }
}
