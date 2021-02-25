import 'package:padong/core/models/deck/post.dart';

/*
* ModelMemo's parentNodeId is ModelTable
* */

class ModelMemo extends ModelPost {
  ModelMemo({
    id,
    title, description,
    attachments, anonymity,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id, type: "Memo",
          title:title, description: description,
          attachments: attachments, anonymity: anonymity,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelMemo.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
