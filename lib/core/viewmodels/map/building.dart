import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/map/building.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelBuilding's parentNodeId is ModelMap
* */

class Building extends ModelBuilding {
  static final FirestoreAPI _buildingDB = locator<FirestoreAPI>("Firestore:building");

  Building({
    id,
    title, description,
    lat, lng,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          lat: lat, lng: lng,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Building.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Building> getBuildingById(String id) async {
    DocumentSnapshot docBuilding = await _buildingDB.ref.doc(id).get();
    if (docBuilding.exists){
      return Building.fromMap(docBuilding.data(), docBuilding.id);
    }
    throw Exception("BuildingId doesn't exists");
  }

}

