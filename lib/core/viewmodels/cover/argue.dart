import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/cover/argue.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:padong/locator.dart';

/*
* ModelArgue's parentNodeId is ModelItem
* */

class Argue extends ModelArgue {
  static final FirestoreAPI _argueDB = locator<FirestoreAPI>("Firestore:argue");

  Argue({
    id,
    title, description,
    isClosed,
    anonymity,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          description: description,
          anonymity: anonymity,
          isClosed: isClosed,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Argue.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Argue> getArgueById(String id) async {
    DocumentSnapshot docArgue = await _argueDB.ref.doc(id).get();
    if (docArgue.exists){
      return Argue.fromMap(docArgue.data(), docArgue.id);
    }
    throw Exception("ArgueId doesn't exists");
  }

}
