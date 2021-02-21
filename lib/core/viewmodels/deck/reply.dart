import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/deck/reply.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelReply's parentNodeId is ModelPost
* */
class Reply extends ModelReply {
  static final FirestoreAPI _replyDB = locator<FirestoreAPI>("Firestore:reply");

  Reply({
    id,
    description, anonymity,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          description: description, anonymity: anonymity,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt
      );

  Reply.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Reply> getReplyById(String id) async {
    DocumentSnapshot docReply = await _replyDB.ref.doc(id).get();
    if (docReply.exists){
      return Reply.fromMap(docReply.data(), docReply.id);
    }
    throw Exception("ReplyId doesn't exists");
  }

}

