import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/map/tip.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelTip's parentNodeId is ModelService
* */

class Tip extends ModelTip {
  static final FirestoreAPI _tipDB = locator<FirestoreAPI>("Firestore:tip");

  Tip({
    id,
    title, description,
    score,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          description: description,
          score: score,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);


  Tip.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Tip> getTipById(String id) async {
    DocumentSnapshot docTip = await _tipDB.ref.doc(id).get();
    if (docTip.exists){
      return Tip.fromMap(docTip.data(), docTip.id);
    }
    throw Exception("TipId doesn't exists");
  }

}

