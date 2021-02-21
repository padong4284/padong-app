import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/deck/re_reply.dart';
import 'package:padong/core/services/firestore_api.dart';
import 'package:padong/locator.dart';

/*
* ModelReReply's parentNodeId is ModelReply
* */
class ReReply extends ModelReReply {
  static final FirestoreAPI _reReplyDB = locator<FirestoreAPI>("Firestore:rereply");
  //static final PadongAuth _session = locator<PadongAuth>();

  ReReply({
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

  ReReply.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<ReReply> getReReplyById(String id) async {
    DocumentSnapshot docReReply = await _reReplyDB.ref.doc(id).get();
    if (docReReply.exists){
      return ReReply.fromMap(docReReply.data(), docReReply.id);
    }
    throw Exception("ReReplyId doesn't exists");
  }

  /*getParent() async {
    DocumentSnapshot docReply = await _replyDB.ref.doc(this.parentNodeId).get();
    if (docReply.exists){
      return
    }
  }

  getParent() async {
    DocumentSnapshot docReply = await _replyDB.ref.doc(this.parentNodeId).get();
    if (docReply.exists){
      return
    }
  }*/


}

