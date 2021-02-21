import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/cover/cover.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:padong/locator.dart';

/*
* ModelCover's parentNodeId is ModelUniversity
* */

class Cover extends ModelCover {
  static final FirestoreAPI _coverDB = locator<FirestoreAPI>("Firestore:cover");

  Cover({
    id,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Cover.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Cover> getCoverById(String id) async {
    DocumentSnapshot docArgue = await _coverDB.ref.doc(id).get();
    if (docArgue.exists){
      return Cover.fromMap(docArgue.data(), docArgue.id);
    }
    throw Exception("CoverId doesn't exists");
  }

}
