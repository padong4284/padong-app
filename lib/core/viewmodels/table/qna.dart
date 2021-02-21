import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/event/qna.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelQnA's parentNodeId is ModelLecture
* */

class QnA extends ModelQnA {
  static final FirestoreAPI _qnaDB = locator<FirestoreAPI>("Firestore:qna");

  QnA({
    id,
    title, description,
    anonymity, attachments,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          anonymity: anonymity, attachments: attachments,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);


  QnA.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<QnA> getQnAById(String id) async {
    DocumentSnapshot docQnA = await _qnaDB.ref.doc(id).get();
    if (docQnA.exists){
      return QnA.fromMap(docQnA.data(), docQnA.id);
    }
    throw Exception("QnAId doesn't exists");
  }

}

