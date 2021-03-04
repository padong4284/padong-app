import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/map/map.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';

/*
* ModelMap's parentNodeId is ModelUniversity
* */

class ViewMap extends ModelMap {
  static final FirestoreAPI _mapDB = locator<FirestoreAPI>("Firestore:map");

  ViewMap({id, parentNodeId, ownerId, pip, createdAt, deletedAt,
    modifiedAt}):
        super(id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ViewMap.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<ViewMap> getMapById(String id) async {
    DocumentSnapshot docMap = await _mapDB.ref.doc(id).get();
    if (docMap.exists){
      return ViewMap.fromMap(docMap.data(), docMap.id);
    }
    throw Exception("MapId doesn't exists");
  }

}

