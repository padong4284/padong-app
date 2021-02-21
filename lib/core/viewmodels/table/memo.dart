import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/event/memo.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelMemo's parentNodeId is ModelTable
* * */
class Memo extends ModelMemo {
  static final FirestoreAPI _memoDB = locator<FirestoreAPI>("Firestore:memo");

  Memo({
    id,
    title, description,
    attachments, anonymity,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          attachments: attachments, anonymity: anonymity,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  Memo.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<Memo> getMemoById(String id) async {
    DocumentSnapshot docMemo = await _memoDB.ref.doc(id).get();
    if (docMemo.exists){
      return Memo.fromMap(docMemo.data(), docMemo.id);
    }
    throw Exception("MemoId doesn't exists");
  }

}

