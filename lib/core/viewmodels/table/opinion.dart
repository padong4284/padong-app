import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/event/opinion.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelOpinion's parentNodeId is ModelReview
* */

class Opinion extends ModelOpinion {
  static final FirestoreAPI _opinionDB = locator<FirestoreAPI>("Firestore:opinion");

  Opinion({
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


  Opinion.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Opinion> getOpinionById(String id) async {
    DocumentSnapshot docOpinion = await _opinionDB.ref.doc(id).get();
    if (docOpinion.exists){
      return Opinion.fromMap(docOpinion.data(), docOpinion.id);
    }
    throw Exception("OpinionId doesn't exists");
  }

}

